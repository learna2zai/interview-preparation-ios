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
    
    init(usecase: FetchProfileUseCase) {
        self.fetchProfileUseCase = usecase
    }
    
    func fetchUserDetails() {
        Task {
            do {
                let user = try await fetchProfileUseCase.execute()
                self.user = user
            } catch {
                print("Handel Error \(error.localizedDescription)")
            }
        }
    }
}
