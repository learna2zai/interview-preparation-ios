//
//  LoginViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    var isLoding: Bool = false
    var errorMessage: String? = nil
    
    private let loginUseCase: LoginUseCase
    private let appViewModel: AppViewModel
    
    init(usecase: LoginUseCase, appViewModel: AppViewModel) {
        self.loginUseCase = usecase
        self.appViewModel = appViewModel
    }
    
    func login() {
        Task {
            isLoding = true
            defer { isLoding = false }
            do {
                try await loginUseCase.execute(email: email, password: password)
                self.appViewModel.setLoggedInStatus(true)
            } catch {
                print("Handle error - \(error.localizedDescription)")
            }
        }
    }
}
