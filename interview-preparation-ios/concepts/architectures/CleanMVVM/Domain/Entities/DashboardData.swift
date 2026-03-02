//
//  DashboardData.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct DashboardData {
    let user: User
    let reports: [Report]
}

struct Report {
    let id: String
    let title: String
    let date: Date
    let count: Int
}
