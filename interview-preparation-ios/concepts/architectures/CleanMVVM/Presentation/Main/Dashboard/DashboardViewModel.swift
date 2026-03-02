//
//  DashboardViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine

@Observable
final class DashboardViewModel: ViewModel {
    
    var dashboardData: DashboardData = .init(user: .init(id: 0, name: "", email: ""), reports: [])
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let useCase: DashboardUseCase
    private let analytics: AnalyticsTracking
    
    init(useCase: DashboardUseCase,
         analytics: AnalyticsTracking) {
        self.useCase = useCase
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedDashboardScreen)
    }
    
    func fetchDetails() async {
        isLoading = true
        defer { isLoading = false }
        do {
            dashboardData = try await useCase.execute(userId: 1)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
