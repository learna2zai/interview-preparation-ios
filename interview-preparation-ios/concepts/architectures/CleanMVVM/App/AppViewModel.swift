//
//  AppViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine
import SwiftUI

enum AppRoute {
    case register
    case login
    case dashboard
}

@Observable
final class AppViewModel {
    
    var path = NavigationPath()
    var currentRoute: AppRoute = .login
    private var isLoggIn: Bool = false
    
    func setLoggedInStatus(_ status: Bool) {
        isLoggIn = status
        currentRoute = isLoggIn ? .dashboard : .login
    }
}
