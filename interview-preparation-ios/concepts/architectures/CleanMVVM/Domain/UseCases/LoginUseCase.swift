//
//  LoginUseCase.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository
    
    init(repository: AuthRepository) {
        self.authRepository = repository
    }
    
    func execute(email: String, password: String) async throws -> Bool {
        try await authRepository.login(email: email, password: password)
    }
}
