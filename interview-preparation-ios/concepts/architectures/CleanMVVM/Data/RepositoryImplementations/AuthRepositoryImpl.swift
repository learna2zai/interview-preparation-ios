//
//  AuthRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

struct LoginRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/auth/mobile/login" }
    
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

struct RegisterRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/register" }
    
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

struct LogoutRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/auth/mobile/logout" }
    
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

final class AuthRepositoryImpl: AuthRepository {
 
    private let apiClient: APIClient
    private let tokenStore: TokenStoring
    
    init(apiClient: APIClient, tokenStore: TokenStoring) {
        self.apiClient = apiClient
        self.tokenStore = tokenStore
    }
    
    func login(email: String, password: String) async throws -> Bool {
        let loginUserDTO = LoginUserDTO(email: email, password: password)
        let encodedData = try JSONEncoder().encode(loginUserDTO)
        try await tokenStore.clearTokens()
        let response: TokenResponseModel = try await apiClient.send(LoginRequest(body: encodedData))
        try await tokenStore.save(accessToken: response.accessToken, refreshToken: response.refreshToken)
        return true
    }
    
    func register(name: String, email: String, password: String) async throws -> Bool {
        let registerUserDTO = RegisterUserDTO(name: name, email: email, password: password)
        let encodedData = try JSONEncoder().encode(registerUserDTO)
        return try await apiClient.send(RegisterRequest(body: encodedData))
    }
    
    func logout() async throws -> Bool {
        let refreshToken = try await tokenStore.getRefreshToken()
        let encodedData = try JSONEncoder().encode(["token": refreshToken ?? ""])
        try await tokenStore.clearTokens()
        let response: LogoutResponseModel = try await apiClient.send(LogoutRequest(body: encodedData))
        
        return response.status
    }
}
