//
//  MockLoginUseCase.swift
//  interview-preparation-iosTests
//
//  Created on 23/02/26.
//

import Foundation
@testable import interview_preparation_ios

protocol MockLoginUseCaseProtocol: LoginUseCaseProtocol, MockShouldFaileProtocol {}

final class MockLoginUseCase: MockLoginUseCaseProtocol {
    var shouldFail: Bool = false
    
    func execute(email: String, password: String) async throws -> Bool {
        if shouldFail {
            throw MockAPIError.mockError
        }
        return true
    }
}

