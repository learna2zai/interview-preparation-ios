//
//  SettingsDIContainer.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class SettingsDIContainer {
    
    private let core: CoreDIContainer
    private lazy var respository = AuthRepositoryImpl(apiClient: core.apiClient,
                                                      tokenStore: core.tokenStore)
    
    private let appViewModel: AppViewModel
    
    init(core: CoreDIContainer, appViewModel: AppViewModel) {
        self.core = core
        self.appViewModel = appViewModel
    }
    
    func makeSettingsView() -> SettingsView {
        let usecase = LogoutUseCase(authRepository: respository)
        let viewModel = SettingsViewModel(usecase: usecase, appViewModel: appViewModel)
        return SettingsView(viewModel: viewModel)
    }
}
