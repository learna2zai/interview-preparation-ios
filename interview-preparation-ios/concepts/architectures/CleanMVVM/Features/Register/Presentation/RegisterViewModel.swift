//
//  RegisterViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class RegisterViewModel: ViewModel {

    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let registerUseCase: RegisterUseCase
    private let appViewModel: AppViewModel
    private let analytics: AnalyticsTracking
    
    init(usecase: RegisterUseCase, appViewModel: AppViewModel, analytics: AnalyticsTracking ) {
        self.registerUseCase = usecase
        self.appViewModel = appViewModel
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedRegisterScreen)
    }
    
    func goToLogin() {
        appViewModel.currentRoute = .login
    }
    
    func register() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await registerUseCase.execute(name: name, email: email, password: password)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
