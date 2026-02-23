//
//  DashboardViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class DashboardViewModel {
    var user: User?
    
    private let fetchProfileUseCase: FetchProfileUseCase
    private let analytics: AnalyticsTracking
    
    init(usecase: FetchProfileUseCase, analytics: AnalyticsTracking) {
        self.fetchProfileUseCase = usecase
        self.analytics = analytics
    }
    
    func trckScreenView() {
        analytics.track(.viewedDashboard)
    }
    
    func fetchUserDetails() async {
        do {
            let user = try await fetchProfileUseCase.execute()
            self.user = user
        } catch {
            print("Handel Error \(error.localizedDescription)")
        }
    }
}
