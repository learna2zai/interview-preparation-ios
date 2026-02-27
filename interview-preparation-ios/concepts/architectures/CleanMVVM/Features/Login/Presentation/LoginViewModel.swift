//
//  LoginViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class LoginViewModel: ViewModel {
    
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let loginUseCase: LoginUseCaseProtocol
    private let appViewModel: AppViewModel
    private let analytics: AnalyticsTracking
    
    init(usecase: LoginUseCaseProtocol,
         appViewModel: AppViewModel,
         analytics: AnalyticsTracking
    ) {
        self.loginUseCase = usecase
        self.appViewModel = appViewModel
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedLoginScreen)
    }
    
    func goToRegister() {
        self.appViewModel.currentRoute = .register
    }
    
    func login() async {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all the fields."
            return
        }
        analytics.track(.logginTapped)
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await loginUseCase.execute(email: email, password: password)
            self.appViewModel.setLoggedInStatus(result)
            analytics.track(.loginSuccess)
        } catch {
            analytics.track(.loginFailed)
            self.errorMessage = "Error: \(error.localizedDescription)"
        }
    }
}
