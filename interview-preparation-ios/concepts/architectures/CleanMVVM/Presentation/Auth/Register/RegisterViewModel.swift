/// RegisterViewModel.swift
/// View model responsible for handling registration screen state, input validation,
/// analytics tracking, and coordinating the register use case.
//
//  RegisterViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine

/// A view model that manages the user registration flow.
///
/// `RegisterViewModel` holds user-entered details, exposes loading and error state
/// for the UI, triggers the register use case, and emits analytics events for key
/// interactions such as screen views and register attempts.
@Observable
final class RegisterViewModel: ViewModel {

    /// The full name entered by the user.
    var name: String = ""
    /// The email address entered by the user.
    var email: String = ""
    /// The password entered by the user.
    var password: String = ""
    /// The confirmation password that must match `password`.
    var confirmPassword: String = ""
    
    /// Indicates whether a registration operation is currently in progress.
    var isLoading: Bool = false
    /// An optional error message to present when validation or registration fails.
    var errorMessage: String? = nil
    
    /// Use case that performs the registration with the provided details.
    private let registerUseCase: RegisterUseCase
    /// Analytics tracker used to record screen views and registration-related events.
    private let analytics: AnalyticsTracking
    
    /// Creates a new register view model.
    /// - Parameters:
    ///   - usecase: The register use case to execute with the provided user details.
    ///   - analytics: The analytics tracker used to record user interactions and outcomes.
    init(usecase: RegisterUseCase,
         analytics: AnalyticsTracking ) {
        self.registerUseCase = usecase
        self.analytics = analytics
    }
    
    /// Tracks an analytics event indicating that the registration screen became visible.
    func trackScreenView() {
        analytics.track(.viewedRegisterScreen)
    }
    
    /// Attempts to register using the current `name`, `email`, `password`, and `confirmPassword`.
    ///
    /// Performs input validation (including non-empty fields and matching passwords), records
    /// analytics for the attempt and result, updates `isLoading` while the operation is in
    /// progress, and sets `errorMessage` if validation fails or the use case throws an error.
    /// - Returns: `true` if registration succeeds, otherwise `false`.
    func register() async -> Bool {
        if email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty  {
            errorMessage = "Please fill in all the fields."
            return false
        } else if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return false
        }
        
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
            analytics.track(.registerFailed)
            self.errorMessage = error.localizedDescription
        }
        return false
    }
}

