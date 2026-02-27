//
//  FetchUsersUseCase.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class FetchUsersUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> [User] {
        try await userRepository.getUsers()
    }
}
