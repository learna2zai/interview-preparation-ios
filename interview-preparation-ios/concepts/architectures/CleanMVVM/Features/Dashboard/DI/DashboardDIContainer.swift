//
//  DashboardDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class DashboardDIContainer {
    
    private let core: CoreDIContainer
    private lazy var respostaitory = UserRepositoryImpl(apiClient: core.apiClient)
    
    init(core: CoreDIContainer) {
        self.core = core
    }
    
    func makeDashboardView() -> DashboardView {
        
        let fetchUsersUseCase = FetchUsersUseCase(userRepository: respostaitory)
        let viewModel = DashboardViewModel(usecase: fetchUsersUseCase,
                                           analytics: core.analyticsService)
        return DashboardView(viewModel: viewModel)
    }
}
