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
    
    private let registerUseCase: RegisterUseCase
    
    init(usecase: RegisterUseCase) {
        self.registerUseCase = usecase
    }
    
    func register() {
        Task {
            do {
                try await registerUseCase.execute(name: name, email: email, password: password)
            } catch {
                print("Handle Error \(error.localizedDescription)")
            }
        }
    }
}
