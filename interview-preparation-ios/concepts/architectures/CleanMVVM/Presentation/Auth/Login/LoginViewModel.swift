/// LoginViewModel.swift
/// View model responsible for handling login screen state, input validation,
/// analytics tracking, and coordinating the login use case.
//

import Foundation
import Combine

/// A view model that manages the login flow.
///
/// `LoginViewModel` holds user-entered credentials, exposes loading and error state
/// for the UI, triggers the login use case, and emits analytics events for key
/// interactions such as screen views and login attempts.
@Observable
final class LoginViewModel: ViewModel {
    
    /// The email address entered by the user.
    var email: String = ""
    /// The password entered by the user.
    var password: String = ""
    /// Indicates whether a login operation is currently in progress.
    var isLoading: Bool = false
    /// An optional error message to present when validation or login fails.
    var errorMessage: String? = nil
    
    /// Use case that performs the login operation with the provided credentials.
    private let loginUseCase: LoginUseCase
    /// Analytics tracker used to record screen views and login-related events.
    private let analytics: AnalyticsTracking
    
    /// Creates a new login view model.
    /// - Parameters:
    ///   - usecase: The login use case to execute with the provided credentials.
    ///   - analytics: The analytics tracker used to record user interactions and outcomes.
    init(usecase: LoginUseCase,
         analytics: AnalyticsTracking) {
        self.loginUseCase = usecase
        self.analytics = analytics
    }
    
    /// Tracks an analytics event indicating that the login screen became visible.
    func trackScreenView() {
        analytics.track(.viewedLoginScreen)
    }
    
    /// Attempts to log in using the current `email` and `password`.
    ///
    /// Performs basic input validation, records analytics for the attempt and result,
    /// updates `isLoading` while the operation is in progress, and sets `errorMessage`
    /// if validation fails or the use case throws an error.
    /// - Returns: `true` if login succeeds, otherwise `false`.
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
                return true
            }
        } catch {
            analytics.track(.loginFailed)
            self.errorMessage = "Error: \(error.localizedDescription)"
        }
        return false
    }
}
