//
//  DataContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol DataContainerProtocol {
    var authRepository: AuthRepository { get }
    var userRepository: UserRepository { get }
    var dashboardRepository: DashboardRepository { get }
    var notificationRepository: NotificationRepository { get }
    var taskRepository: TaskRepository { get }
}


final class DataContainer: DataContainerProtocol {

    private let core: CoreContainerProtocol
    private let swiftDataManager: SwiftDataManager

    init(core: CoreContainerProtocol) {
        self.core = core
        self.swiftDataManager = SwiftDataManager()
    }

    lazy var authRepository: AuthRepository = {
        AuthRepositoryImpl(
            apiClient: core.apiClient,
            tokenStore: core.tokenStore
        )
    }()

    lazy var userRepository: UserRepository = {
        UserRepositoryImpl(apiClient: core.apiClient)
    }()

    lazy var dashboardRepository: DashboardRepository = {
        DashboardRepositoryImpl(apiClient: core.apiClient)
    }()

    lazy var notificationRepository: NotificationRepository = {
        NotificationRepositoryImpl(apiClient: core.apiClient)
    }()

    lazy var taskRepository: TaskRepository = {
        TaskRepositoryImpl(modelContext: swiftDataManager.modelContext)
    }()
}
