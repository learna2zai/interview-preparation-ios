//
//  FetchProfileUseCase.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class FetchProfileUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> User {
        try await userRepository.getProfile()
    }
}
