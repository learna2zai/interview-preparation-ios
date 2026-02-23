//
//  RegisterViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class RegisterViewModel {
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let registerUseCase: RegisterUseCase
    
    init(usecase: RegisterUseCase) {
        self.registerUseCase = usecase
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
