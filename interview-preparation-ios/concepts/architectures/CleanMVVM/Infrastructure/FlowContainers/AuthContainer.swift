//
//  AuthContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class AuthContainer {

    private var core: CoreContainerProtocol
    
    init(core: CoreContainerProtocol) {
        self.core = core
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        let authRepository = AuthRepositoryImpl(apiClient: core.apiClient,
                                                tokenStore: core.tokenStore)
        let loginUseCase = LoginUseCase(repository: authRepository)
            
        return LoginViewModel(usecase: loginUseCase, analytics: core.analytics)
    }
    
    func makeRegisterViewModel() -> RegisterViewModel {
        let authRepository = AuthRepositoryImpl(apiClient: core.apiClient,
                                                tokenStore: core.tokenStore)
        let registerUseCase = RegisterUseCase(repository: authRepository)
        
        return RegisterViewModel(usecase: registerUseCase, analytics: core.analytics)
    }
}
