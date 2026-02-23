//
//  FirebaseAnalyticsService.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation

final class FirebaseAnalyticsService: AnalyticsTracking {
    
    func track(_ event: AnalyticsEvents) {
        switch event {
            case .logginTapped:
               logEvent("login_tapped")
            case .loginSuccess:
                logEvent("login_success")
            case .loginFailed:
                logEvent("login_failed")
            case .logout:
                logEvent("logout")
            case .viewedDashboard:
                logEvent("dashboard_viewed")
            case .registerCompleted:
                logEvent("register_completed")
        }
    }
    
    private func logEvent(_ name: String, parameters: [String: Any]? = nil) {
        print("Sending to Firebase Analytics: \(name), \(parameters?.description ?? "")")
//        FirebaseAnalytics.logEvent("login_tapped", parameters: parameters)
    }
}
