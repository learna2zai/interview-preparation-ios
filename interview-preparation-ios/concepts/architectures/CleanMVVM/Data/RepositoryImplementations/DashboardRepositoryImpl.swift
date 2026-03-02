//
//  DashboardRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class DashboardRepositoryImpl: DashboardRepository {

    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsersCount() async throws -> Int {
        1
    }
    
    func fetchPostsCount(forUserId userId: Int) async throws -> Int {
        1
    }
    
    func fetchReports(for userId: Int) async throws -> [Report] {
        [.init(id: "1", title: "First", date: Date.now, count: 3)]
    }
}
