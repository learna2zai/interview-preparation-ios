//
//  DashboardUseCase.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class DashboardUseCase {
    
    private var dashboardRepository: DashboardRepository
    private var userRepository: UserRepository
    
    init(dashboardRepository: DashboardRepository,
         userRepository: UserRepository) {
        self.dashboardRepository = dashboardRepository
        self.userRepository = userRepository
    }
    
    func execute(userId: Int) async throws -> DashboardData {
        async let user = await userRepository.getUser(userId: userId)
        async let reports = await dashboardRepository.fetchReports(for: userId)
        
        return try await DashboardData(user: user, reports: reports)
    }
}
