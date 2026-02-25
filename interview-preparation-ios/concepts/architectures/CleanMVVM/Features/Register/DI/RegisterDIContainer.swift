//
//  RegisterDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 25/02/26.
//

import Foundation

final class RegisterDIContainer {
    
    private let core: CoreDIContainer
    private lazy var repository: AuthRepository = AuthRepositoryImpl(apiClient: core.apiClient)
    
    init(core: CoreDIContainer) {
        self.core = core
    }
    
    func makeRegisterView(appViewModel: AppViewModel) -> RegisterView {
        
        let registerUseCase = RegisterUseCase(repository: repository)
        let viewModel = RegisterViewModel(usecase: registerUseCase, appViewModel: appViewModel, analytics: core.analyticsService)
            
        return RegisterView(viewModel: viewModel)
    }
}
