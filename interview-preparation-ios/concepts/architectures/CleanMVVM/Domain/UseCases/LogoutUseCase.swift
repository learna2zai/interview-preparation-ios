//
//  LogoutUseCase.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class LogoutUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> Bool {
        true
        //try await authRepository.logout()
    }
}
