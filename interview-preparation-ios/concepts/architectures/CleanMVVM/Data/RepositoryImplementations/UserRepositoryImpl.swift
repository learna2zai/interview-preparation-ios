//
//  UserRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getProfile() async throws -> User {
        let userDTO = try await apiClient.fetchProfile()
        let user = User(name: userDTO.name, email: userDTO.email)
        return user
    }
}
