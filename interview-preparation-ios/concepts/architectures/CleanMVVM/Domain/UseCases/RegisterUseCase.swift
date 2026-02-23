//
//  RegisterUseCase.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class RegisterUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(name: String, email: String, password: String) async throws -> Bool {
        try await repository.register(name: name, email: email, password: password)
    }
}
