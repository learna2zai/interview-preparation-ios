//
//  LoginDIContainer.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class LoginDIContainer {
    
    private let core: CoreDIContainer
    private lazy var repository = AuthRepositoryImpl(apiClient: core.apiClient,
                                                     tokenStore: core.tokenStore)
    
    init(core: CoreDIContainer) {
        self.core = core
    }
    
    func makeLoginView(appState: AppViewModel) -> LoginView {
        let usecase = LoginUseCase(repository: repository)
        let viewModel = LoginViewModel(usecase: usecase,
                                       appViewModel: appState,
                                       analytics: core.analyticsService)
        return LoginView(viewModel: viewModel)
    }
}
