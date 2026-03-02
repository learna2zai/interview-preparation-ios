//
//  RegisterViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
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
    private let analytics: AnalyticsTracking
    
    init(usecase: RegisterUseCase,
         analytics: AnalyticsTracking ) {
        self.registerUseCase = usecase
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedRegisterScreen)
    }
    
    func register() async -> Bool {
        analytics.track(.registerTapped)
        isLoading = true
        defer { isLoading = false }
        
        do {
            if try await registerUseCase.execute(name: name,
                                                 email: email,
                                                 password: password) {
                analytics.track(.registerSuccess)
                return true
            }
        } catch {
            analytics.track(.registerfailed)
            self.errorMessage = error.localizedDescription
        }
        return false
    }
}
