//
//  LoginDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class LoginDIContainer {
    
    private let core: CoreDIContainer
    private lazy var repository = AuthRepositoryImpl(apiClient: core.apiClient)
    
    init(core: CoreDIContainer) {
        self.core = core
    }
    
    func makeLoginView(appState: AppViewModel) -> LoginView {
        let usecase = LoginUseCase(repository: repository)
        let viewModel = LoginViewModel(usecase: usecase, appViewModel: appState)
        return LoginView(viewModel: viewModel)
    }
}
