//
//  LoginViewModelTests.swift
//  interview-preparation-iosTests
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Testing
@testable import interview_preparation_ios

@MainActor
struct LoginViewModelTests {
    
    let usecase = MockLoginUseCase()
    let appViewModel = AppViewModel()
    let mockAnalytics = MockAnalytics()
    private var viewModel: LoginViewModel
    
    init() {
        self.viewModel = .init(usecase: usecase,
                               appViewModel: appViewModel,
                               analytics: mockAnalytics)
    }
    
    @Test("Verify login success")
    func loginUser() async {

        #expect(viewModel.isLoding == false)
        #expect(viewModel.errorMessage == nil)
        
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        
        await viewModel.login()
        
        #expect(appViewModel.currentRoute == .dashboard)
        #expect(mockAnalytics.trackedEvents.contains(.logginTapped))
        #expect(mockAnalytics.trackedEvents.contains(.loginSuccess))
    }
    
    @Test("Verify login failure")
    func loginUserFailure() async {
        
        usecase.shouldFail = true
        await viewModel.login()

        #expect(viewModel.isLoding == false)
        #expect(viewModel.errorMessage != nil)
        #expect(mockAnalytics.trackedEvents.contains(.loginFailed))
    }
}
