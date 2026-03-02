//
//  LoginViewModelTests.swift
//  interview-preparation-iosTests
//
//  Created on 23/02/26.
//

import Foundation
import Testing
@testable import interview_preparation_ios

@MainActor
@Suite("LoginViewModel Tests")
struct LoginViewModelTests {
    
    let mockRepository = MockAuthRepository()
    let mockAnalytics = MockAnalytics()
    private var viewModel: LoginViewModel
    
    init() {
        self.viewModel = .init(usecase: LoginUseCase(repository: mockRepository),
                               analytics: mockAnalytics)
    }
    
    @Test("Validation fails when fields are empty")
    func emptyFieldsValidation() async {

        // Both empty
        let result1 = await viewModel.login()
        #expect(result1 == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.isLoading == false)

        // Email only
        viewModel.email = "user@example.com"
        viewModel.password = ""
        let result2 = await viewModel.login()
        #expect(result2 == false)
        #expect(viewModel.errorMessage != nil)

        // Password only
        viewModel.email = ""
        viewModel.password = "secret"
        let result3 = await viewModel.login()
        #expect(result3 == false)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test("Verify login success")
    func loginUser() async {

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        
        let result = await viewModel.login()
        #expect(result == true)
        #expect(mockAnalytics.trackedEvents.contains(.logginTapped))
        #expect(mockAnalytics.trackedEvents.contains(.loginSuccess))
    }
    
    @Test("Verify login failure")
    func loginUserFailure() async {
        mockRepository.shouldFail = true
        
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        let result = await viewModel.login()
        
        #expect(result == false)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(mockAnalytics.trackedEvents.contains(.loginFailed))
    }
}
