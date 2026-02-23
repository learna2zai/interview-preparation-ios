//
//  AuthRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
 
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(email: String, password: String) async throws -> Bool {
        try await apiClient.login(email: email, passowrd: password)
    }
    
    func register(name: String, email: String, password: String) async throws -> Bool {
        try await apiClient.register(name: name, email: email, password: password)
    }
    
    func logout() async throws -> Bool {
        try await apiClient.logout()
    }
}
