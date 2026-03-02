//
//  AppContainer.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

import SwiftData

final class SwiftDataManager {
    
    var modelContext: ModelContext
    
    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: TaskEntity.self, configurations: configuration)
            self.modelContext = ModelContext(container)
        }
        catch {
            fatalError("Could not create model container Error: \(error.localizedDescription)")
        }
    }
}

final class AppContainer {

    let core: CoreContainerProtocol
//    let data: DataContainerProtocol
//    let domain: DomainContainerProtocol
//    let presentation: PresentationContainerProtocol

    init(environment: AppEnvironment) {

        let core = CoreContainer(
            environment: environment,
            analytics: AnalyticsService(),
            tokenStore: TokenStore()
        )

//        let data = DataContainer(core: core)
//        let domain = DomainContainer(data: data)
//        let presentation = PresentationContainer(domain: domain, core: core)

        self.core = core
//        self.data = data
//        self.domain = domain
//        self.presentation = presentation
    }
}


//final class AppContainer {
//    
//    // MARK: - Core
//    
//    private var environment: AppEnvironment
//    private let analytics: AnalyticsTracking
//    private let tokenStore: TokenStoring
//    private lazy var dataManager = SwiftDataManager()
//    
//    private var apiClient: APIClient {
//        APIClient(baseUrl: environment.baseURL,
//                  interceptorPipeline: InterceptorPipeline(interceptors: []),
//                  refreshTokenService: refreshTokenService)
//    }
//    private var refreshTokenService: RefreshTokenServiceProtocol
//    
//    init(environment: AppEnvironment,
//         analytics: AnalyticsTracking = AnalyticsService(),
//         tokenStore: TokenStore = TokenStore(),
//         refreshTokenService: RefreshTokenServiceProtocol? = nil) {
//        self.environment = environment
//        self.analytics = analytics
//        self.tokenStore = tokenStore
//        self.refreshTokenService = refreshTokenService ?? RefreshTokenService(tokenStore: self.tokenStore)
//    }
//    
//    func updateEnvironment(_ environment: AppEnvironment) {
//        self.environment = environment
//    }
//    
//    // MARK: - Repositories
//    
//    lazy var authRepository: AuthRepository = {
//        AuthRepositoryImpl(apiClient: apiClient,
//                           tokenStore: tokenStore)
//    }()
//    
//    lazy var userRepository: UserRepository = {
//        UserRepositoryImpl(apiClient: apiClient)
//    }()
//    
//    lazy var dashboardRepository: DashboardRepository = {
//        DashboardRepositoryImpl(apiClient: apiClient)
//    }()
//    
//    lazy var notificationRepository: NotificationRepository = {
//        NotificationRepositoryImpl(apiClient: apiClient)
//    }()
//    
//    lazy var taskRepository = {
//        TaskRepositoryImpl(modelContext: dataManager.modelContext)
//    }()
//    
//    
//    //MARK: - UseCases
//    
//    func makeLoginUseCase() -> LoginUseCase {
//        LoginUseCase(repository: authRepository)
//    }
//    
//    func makeRegisterUseCase() -> RegisterUseCase {
//        RegisterUseCase(repository: authRepository)
//    }
//    
//    func makeFetchUsersUseCase() -> FetchUsersUseCase {
//        FetchUsersUseCase(userRepository: userRepository)
//    }
//    
//    func makeDashboardUseCase() -> DashboardUseCase {
//        DashboardUseCase(dashboardRepository: dashboardRepository,
//                         userRepository: userRepository)
//    }
//    
//    func makeNotificationsUseCase() -> NotificationsUseCase {
//        NotificationsUseCase(notificationRepository: notificationRepository)
//    }
//    
//    func makeLogoutUseCase() -> LogoutUseCase {
//        LogoutUseCase(authRepository: authRepository)
//    }
//    
//    
//    // MARK: - ViewModels
//    
//    func makeLoginViewModel() -> LoginViewModel {
//        LoginViewModel(usecase: makeLoginUseCase(),
//                       analytics: analytics)
//    }
//    
//    func makeRegisterViewModel() -> RegisterViewModel {
//        RegisterViewModel(usecase: makeRegisterUseCase(),
//                          analytics: analytics)
//    }
//    
//    func makeDashboardViewModel() -> DashboardViewModel {
//        DashboardViewModel(useCase: makeDashboardUseCase(),
//                           analytics: analytics)
//    }
//    
//    func makeTaskListViewModel() -> TaskListViewModel {
//        TaskListViewModel(taskRepository: taskRepository)
////                                  taskSyncEngine: TaskSyncEngine(modelContext: modelContext,
////                                                                 api: TaskAPI()))
//    }
//    
//    func makeSettingsViewModel() -> SettingsViewModel {
//        SettingsViewModel(logoutUseCase: makeLogoutUseCase(),
//                          notifocationsUseCase: makeNotificationsUseCase(),
//                          analytics: analytics)
//    }
//}
