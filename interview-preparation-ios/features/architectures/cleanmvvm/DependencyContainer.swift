//
//  DependencyContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class DependencyContainer {
    
    // MARK: - Core
    private let apiClient = APIClient()
    
    // MARK: - Repositories
    private lazy var authRepository = AuthRepositoryImpl(apiClient: apiClient)
    private lazy var userRepository = UserRepositoryImpl(apiClient: apiClient)
    
    // MARK: - App State
    let appViewModel = AppViewModel()
    
    // MARK: - Factories
    
    func makeLoginView() -> LoginView {
        let loginUseCase = LoginUseCase(repository: authRepository)
        let loginViewModel = LoginViewModel(usecase: loginUseCase, appViewModel: appViewModel)
        return LoginView(viewModel: loginViewModel)
    }
    
    func makeRegiserView() -> RegisterView {
        let registerUseCase = RegisterUseCase(repository: authRepository)
        let registerViewModel = RegisterViewModel(usecase: registerUseCase)
        return RegisterView(viewModel: registerViewModel)
    }
    
    func makeDashboardView() -> DashboardView {
        let userUseCase = FetchProfileUseCase(userRepository: userRepository)
        let dashboardViewModel = DashboardViewModel(usecase: userUseCase)
        return DashboardView(viewModel: dashboardViewModel)
    }
    
    func makeSettingsView() -> SettingsView {
        let logoutUseCase = LogoutUseCase(authRepository: authRepository)
        let settingsViewModel = SettingsViewModel(usecase: logoutUseCase, appViewModel: appViewModel)
        return SettingsView(viewModel: settingsViewModel)
    }
}
