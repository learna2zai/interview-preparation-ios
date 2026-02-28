//
//  RefreshTokenService.swift
//  interview-preparation-ios
//
//  Created on 27/02/26.
//

import Foundation

struct RefreshTokenRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/auth/mobile/refreshToken" }
    
    init(method: HTTPMethod = .POST,
         headers: [String : String] = [:],
         body: Data? = nil,
         queryItems: [URLQueryItem]? = nil) {
        self.method = method
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
    }
}

protocol RefreshTokenServiceProtocol {
    func refreshToken(baseURL: String, session: URLSession) async throws -> Bool
}

final class RefreshTokenService: RefreshTokenServiceProtocol {
    private let tokenStore: TokenStoring
    
    init(tokenStore: TokenStoring) {
        self.tokenStore = tokenStore
    }
    
    func refreshToken(baseURL: String, session: URLSession) async throws -> Bool {
        do {
            let refreshToken = try await tokenStore.getRefreshToken()
            let encodedData = try JSONEncoder().encode(["token": refreshToken ?? ""])
            let request = RefreshTokenRequest(body: encodedData)
            let urlRequest = try ConvertAPIRequest().convertToRequest(baseURL, request: request)
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.userAuthenticationRequired)
            }
            let tokens = try JSONDecoder().decode(TokenResponseModel.self, from: data)
            try await tokenStore.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            
            return true
        } catch {
            try await tokenStore.clearTokens()
            throw URLError(.userAuthenticationRequired)
        }
    }
}
