//
//  DomainContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol DomainContainerProtocol {
    func makeLoginUseCase() -> LoginUseCase
    func makeRegisterUseCase() -> RegisterUseCase
    func makeDashboardUseCase() -> DashboardUseCase
    func makeLogoutUseCase() -> LogoutUseCase
    func makeNotificationsUseCase() -> NotificationsUseCase
    func makeTaskListUseCase() -> TaskListUseCase
}

final class DomainContainer: DomainContainerProtocol {

    private let data: DataContainerProtocol

    init(data: DataContainerProtocol) {
        self.data = data
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(repository: data.authRepository)
    }

    func makeRegisterUseCase() -> RegisterUseCase {
        RegisterUseCase(repository: data.authRepository)
    }

    func makeDashboardUseCase() -> DashboardUseCase {
        DashboardUseCase(
            dashboardRepository: data.dashboardRepository,
            userRepository: data.userRepository
        )
    }
    
    func makeNotificationsUseCase() -> NotificationsUseCase {
        NotificationsUseCase(notificationRepository: data.notificationRepository)
    }

    func makeLogoutUseCase() -> LogoutUseCase {
        LogoutUseCase(authRepository: data.authRepository)
    }
    
    func makeTaskListUseCase() -> TaskListUseCase {
        TaskListUseCase(taskRepository: data.taskRepository)
    }
}
