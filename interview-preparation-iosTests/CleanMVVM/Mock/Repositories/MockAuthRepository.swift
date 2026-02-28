//
//  MockAuthRepository.swift
//  interview-preparation-iosTests
//
//  Created on 23/02/26.
//

import Foundation
@testable import interview_preparation_ios

enum MockAPIError: Error {
    case mockError
}

protocol MockShouldFaileProtocol {
    var shouldFail: Bool { get set }
}

protocol MockAuthRepositoryProtocol: AuthRepository, MockShouldFaileProtocol {}

final class MockAuthRepository: MockAuthRepositoryProtocol {
    
    var shouldFail: Bool = false
    
    func login(email: String, password: String) async throws -> Bool {
        if shouldFail {
            throw MockAPIError.mockError
        }
        return true
    }
    
    func register(name: String, email: String, password: String) async throws -> Bool {
        if shouldFail {
            throw NSError(domain: "", code: 0)
        }
        return true
    }
    
    func logout() async throws -> Bool {
        if shouldFail {
            throw NSError(domain: "", code: 0)
        }
        return true
    }
}


