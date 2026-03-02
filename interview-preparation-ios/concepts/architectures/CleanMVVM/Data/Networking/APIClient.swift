//
//  APIClient.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
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
    private let urlSession: URLSession
    private let interceptorPipeline: InterceptorPipeline
    private let refreshTokenService: RefreshTokenServiceProtocol

    init(baseUrl: String,
         urlSession: URLSession = .shared,
         interceptorPipeline: InterceptorPipeline,
         refreshTokenService: RefreshTokenServiceProtocol
    ) {
        self.baseUrl = baseUrl
        self.urlSession = urlSession
        self.interceptorPipeline = interceptorPipeline
        self.refreshTokenService = refreshTokenService
    }

    func send<T>(_ request: any APIRequest) async throws -> T where T : Decodable {
     
        let urlRequest = try ConvertAPIRequest().convertToRequest(baseUrl, request: request)
        let data = try await execute(urlRequest, attempt: 0)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func execute(_ urlRequest: URLRequest, attempt: Int) async throws -> Data  {
        do {
            let adaptedRequest = try await interceptorPipeline.adapt(urlRequest)
            let (data, response) = try await urlSession.data(for: adaptedRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            if httpResponse.statusCode == 401 {
                do {
                    let result = try await refreshTokenService.refreshToken(baseURL: baseUrl,
                                                                            session: urlSession)
                    if attempt < 3, result {
                        return try await execute(urlRequest, attempt: attempt + 1)
                    }
                } catch { throw error }
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                throw URLError(.badServerResponse)
            }
            return data
        }
        catch let error as URLError where [.userAuthenticationRequired].contains(error.code) {
            throw error
        } catch {
            if attempt < 3,
                try await interceptorPipeline.shouldRetry(urlRequest,
                                                           error: error,
                                                           attempt: attempt) {
                return try await execute(urlRequest, attempt: attempt + 1)
            }
            throw error
        }
    }
}
