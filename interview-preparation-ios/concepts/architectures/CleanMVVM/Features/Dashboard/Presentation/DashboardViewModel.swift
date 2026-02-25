//
//  DashboardViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class DashboardViewModel: ViewModel {
    
    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let fetchUsersUseCase: FetchUsersUseCase
    private let analytics: AnalyticsTracking
    
    init(usecase: FetchUsersUseCase, analytics: AnalyticsTracking) {
        self.fetchUsersUseCase = usecase
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedDashboardScreen)
    }
    
    func fetchUserDetails() async {
        isLoading = true
        defer { isLoading = false }
        do {
             users = try await fetchUsersUseCase.execute()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
