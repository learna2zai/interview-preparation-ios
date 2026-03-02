//
//  DashboardCoordinator.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

@Observable
final class DashboardCoordinator {
    
    enum Route: Hashable {
        case users
        case classSchedules
        case subjects
        case reports
    }
    
    var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
}
