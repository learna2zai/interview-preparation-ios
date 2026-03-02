//
//  MainContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class MainContainer {
    
    private let core: CoreContainerProtocol
    private let swiftDataManager: SwiftDataManager
    
    init(core: CoreContainerProtocol) {
        self.core = core
        self.swiftDataManager = SwiftDataManager()
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        let dashboardRepository = DashboardRepositoryImpl(apiClient: core.apiClient)
        let userRepository = UserRepositoryImpl(apiClient: core.apiClient)
        
        let dashboardUseCase = DashboardUseCase(dashboardRepository: dashboardRepository,
                                                userRepository: userRepository)
        return DashboardViewModel(useCase: dashboardUseCase, analytics: core.analytics)
    }
    
    func makeTaskListViewModel() -> TaskListViewModel {
        let taskRepository = TaskRepositoryImpl(modelContext: swiftDataManager.modelContext)
        let taskUseCase = TaskListUseCase(taskRepository: taskRepository)
        return TaskListViewModel(taskListUseCase: taskUseCase)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        let authRepository = AuthRepositoryImpl(apiClient: core.apiClient, tokenStore: core.tokenStore)
        let notificationRepository = NotificationRepositoryImpl(apiClient: core.apiClient)
        let logoutUseCase = LogoutUseCase(authRepository: authRepository)
        let notificationsUseCase = NotificationsUseCase(notificationRepository: notificationRepository)
        return SettingsViewModel(logoutUseCase: logoutUseCase,
                                 notifocationsUseCase: notificationsUseCase,
                                 analytics: core.analytics)
    }
}
