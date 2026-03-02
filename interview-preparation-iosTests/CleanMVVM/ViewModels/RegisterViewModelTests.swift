//
//  RegisterViewModelTests.swift
//  interview-preparation-iosTests
//
//  Created on 23/02/26.
//

import Foundation
import Testing
@testable import interview_preparation_ios

@MainActor
@Suite("RegisterViewModel Tests")
struct RegisterViewModelTests {
    
    let mockRepository = MockAuthRepository()
    let mockAnalytics = MockAnalytics()
    private var viewModel: RegisterViewModel
    
    init() {
        self.viewModel = .init(usecase: RegisterUseCase(repository: mockRepository),
                               analytics: mockAnalytics)
    }
    
    @Test("Validation fails when fields are empty")
    func emptyFieldsValidation() async {
        // All empty
        let result1 = await viewModel.register()
        #expect(result1 == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.isLoading == false)
        
        // Email only
        viewModel.email = "user@example.com"
        viewModel.password = ""
        viewModel.confirmPassword = ""
        let result2 = await viewModel.register()
        #expect(result2 == false)
        #expect(viewModel.errorMessage != nil)
        
        // Password only
        viewModel.email = ""
        viewModel.password = "secret"
        viewModel.confirmPassword = ""
        let result3 = await viewModel.register()
        #expect(result3 == false)
        #expect(viewModel.errorMessage != nil)
        
        // Passwords mismatch
        viewModel.email = "user@example.com"
        viewModel.password = "secret1"
        viewModel.confirmPassword = "secret2"
        let result4 = await viewModel.register()
        #expect(result4 == false)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test("Verify register success")
    func registerUser() async {
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        
        mockRepository.shouldFail = false
        
        viewModel.name = "Name"
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        viewModel.confirmPassword = "password"
        
        let result = await viewModel.register()
        #expect(result == true)
        #expect(mockAnalytics.trackedEvents.contains(.registerTapped))
        #expect(mockAnalytics.trackedEvents.contains(.registerSuccess))
    }
    
    @Test("Verify register failure")
    func registerUserFailure() async {
        mockRepository.shouldFail = true
        
        viewModel.name = "Name"
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        viewModel.confirmPassword = "password"
        
        let result = await viewModel.register()
        
        #expect(result == false)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(mockAnalytics.trackedEvents.contains(.registerFailed))
    }
}
