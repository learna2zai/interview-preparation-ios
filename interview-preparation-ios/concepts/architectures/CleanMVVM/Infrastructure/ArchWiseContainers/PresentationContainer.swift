//
//  PresentationContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol PresentationContainerProtocol {
    func makeLoginViewModel() -> LoginViewModel
    func makeDashboardViewModel() -> DashboardViewModel
    func makeSettingsViewModel() -> SettingsViewModel
    func makeTaskListViewModel() -> TaskListViewModel
    func makeRegisterViewModel() -> RegisterViewModel
}

final class PresentationContainer: PresentationContainerProtocol {

    private let domain: DomainContainerProtocol
    private let core: CoreContainerProtocol

    init(
        domain: DomainContainerProtocol,
        core: CoreContainerProtocol
    ) {
        self.domain = domain
        self.core = core
    }

    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            usecase: domain.makeLoginUseCase(),
            analytics: core.analytics
        )
    }

    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(
            useCase: domain.makeDashboardUseCase(),
            analytics: core.analytics
        )
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(
            logoutUseCase: domain.makeLogoutUseCase(),
            notifocationsUseCase: domain.makeNotificationsUseCase(),
            analytics: core.analytics
        )
    }
    
    func makeTaskListViewModel() -> TaskListViewModel {
        TaskListViewModel(taskListUseCase: domain.makeTaskListUseCase())
    }
    
    func makeRegisterViewModel() -> RegisterViewModel {
        RegisterViewModel(usecase: domain.makeRegisterUseCase(),
                          analytics: core.analytics)
    }
}
