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
    
    private let loginUseCase: LoginUseCaseProtocol
    private let appViewModel: AppViewModel
    
    init(usecase: LoginUseCaseProtocol, appViewModel: AppViewModel) {
        self.loginUseCase = usecase
        self.appViewModel = appViewModel
    }
    
    func login() async {
        isLoding = true
        defer { isLoding = false }
        do {
            let result = try await loginUseCase.execute(email: email, password: password)
            self.appViewModel.setLoggedInStatus(result)
        } catch {
            self.errorMessage = "Error: \(error.localizedDescription)"
        }
    }
}
