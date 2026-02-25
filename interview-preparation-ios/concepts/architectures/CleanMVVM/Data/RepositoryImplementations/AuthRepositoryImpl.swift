//
//  AuthRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

struct LoginRequest: APIRequest {
    var method: HTTPMethod
    var headers: [String : String]
    var body: Data?
    var queryItems: [URLQueryItem]?
    var path: String { "/login" }
    
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

final class AuthRepositoryImpl: AuthRepository {
 
    private let apiClient: APIClient
    private let tokenStore: TokenStoring
    
    init(apiClient: APIClient, tokenStore: TokenStoring = TokenStore()) {
        self.apiClient = apiClient
        self.tokenStore = tokenStore
    }
    
    func login(email: String, password: String) async throws -> Bool {
        let loginUserDTO = LoginUserDTO(email: email, password: password)
        let encodedData = try JSONEncoder().encode(loginUserDTO)
        let response: LoginResponseModel = try await apiClient.send(LoginRequest(body: encodedData))
        try await tokenStore.save(accessToken: response.accessToken, refreshToken: response.refreshToken)
        return true
    }
    
    func register(name: String, email: String, password: String) async throws -> Bool {
        let registerUserDTO = RegisterUserDTO(name: name, email: email, password: password)
        let encodedData = try JSONEncoder().encode(registerUserDTO)
        return try await apiClient.send(RegisterRequest(body: encodedData))
    }
    
    func logout() async throws -> Bool {
//        try await apiClient.logout()
        try await tokenStore.clearTokens()
        return false
    }
}
