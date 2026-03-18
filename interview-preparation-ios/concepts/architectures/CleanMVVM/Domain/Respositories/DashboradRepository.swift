//
//  DashboradRepository.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol DashboardRepository: Sendable {
    func fetchUsersCount() async throws -> Int
    func fetchReports(for userId: Int) async throws -> [Report]
}
