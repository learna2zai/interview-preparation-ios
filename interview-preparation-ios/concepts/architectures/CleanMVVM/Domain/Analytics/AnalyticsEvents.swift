//
//  AnalyticsEvents.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation

enum AnalyticsEvents: String {
    
    case viewedLoginScreen = "login_screen"
    case logginTapped = "login_tapped"
    case loginSuccess = "login_success"
    case loginFailed = "login_failed"
    
    case viewedRegisterScreen = "register_screen"
    case registerTapped = "register_tapped"
    case registerFailed = "register_failed"
    case registerSuccess = "register_success"
    
    case viewedDashboardScreen = "dashboard_screen"
    
    case viewedSettingsScreen = "settings_screen"
    case logout = "logout"
}
