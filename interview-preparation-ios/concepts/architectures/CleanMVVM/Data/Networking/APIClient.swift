//
//  APIClient.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get set}
    var queryItems: [URLQueryItem]? { get }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

protocol NetworkClient {
    func send<T: Decodable>(_ request: APIRequest) async throws -> T
}

final class APIClient: NetworkClient {
    
    private let baseUrl: String
    private let session: URLSession
    private let interceptorPipleline: InterceptorPipeline

    init(baseUrl: String, session: URLSession = .shared, interceptorPipleline: InterceptorPipeline) {
        self.baseUrl = baseUrl
        self.session = session
        self.interceptorPipleline = interceptorPipleline
    }

    func send<T>(_ request: any APIRequest) async throws -> T where T : Decodable {
        guard let url = URL(string: baseUrl),
                var urlComponents = URLComponents(url: url.appendingPathComponent(request.path),
                                                                                resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = request.queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = 30.0
        
        request.headers.forEach({ urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) })
        
        return try await execute(urlRequest, attempt: 0)
    }
    
    private func execute<T>(_ urlRequest: URLRequest, attempt: Int) async throws -> T where T : Decodable {
        do {
            let adaptedRequest = try await interceptorPipleline.adapt(urlRequest)
            let (data, response) = try await session.data(for: adaptedRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if attempt < 3, try await interceptorPipleline.shouldRetry(urlRequest, error: error, attempt: attempt) {
                return try await execute(urlRequest, attempt: attempt + 1)
            }
            throw error
        }
    }
}
