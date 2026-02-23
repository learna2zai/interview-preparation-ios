//
//  LoginUseCaseTests.swift
//  interview-preparation-iosTests
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Testing
@testable import interview_preparation_ios

struct LoginUseCaseTests {
    
    var mockAuthRepository: MockAuthRepositoryProtocol
    let loginUseCase: LoginUseCase
    
    init () {
        self.mockAuthRepository = MockAuthRepository()
        self.loginUseCase = LoginUseCase(repository: mockAuthRepository)
    }
    
    @Test("Verify login success")
    func loginSuccess() async throws {
        let result = try await loginUseCase.execute(email: "test@test.com", password: "password")
        #expect(result == true)
    }
    
    @Test("Verify login failure")
    mutating func loginFailure() async throws {
        mockAuthRepository.shouldFail = true
        let result = try await #require(throws: MockAPIError.self) {
            try await loginUseCase.execute(email: "", password: "")
        }
        #expect(result == .mockError)
    }
}
