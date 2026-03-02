//
//  LoginViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine

@Observable
final class LoginViewModel: ViewModel {
    
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let loginUseCase: LoginUseCase
    private let analytics: AnalyticsTracking
    
    init(usecase: LoginUseCase,
         analytics: AnalyticsTracking) {
        self.loginUseCase = usecase
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedLoginScreen)
    }
    
    func login() async -> Bool {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all the fields."
            return false
        }
        analytics.track(.logginTapped)
        isLoading = true
        defer { isLoading = false }
        do {
            if try await loginUseCase.execute(email: email, password: password) {
                analytics.track(.loginSuccess)
                return try await returnFromLogin()
            }
        } catch {
            analytics.track(.loginFailed)
            self.errorMessage = "Error: \(error.localizedDescription)"
        }
        return false
    }
}

func returnFromLogin() async throws -> Bool {
    return true
}
