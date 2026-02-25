//
//  AnalyticsService.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation

final class AnalyticsService: AnalyticsTracking {
    
    func track(_ event: AnalyticsEvents) {
        logEvent(event.rawValue)
    }
    
    private func logEvent(_ name: String, parameters: [String: Any]? = nil) {
        print("Sending to Firebase Analytics: \(name), \(parameters?.description ?? "")")
//        FirebaseAnalytics.logEvent("login_tapped", parameters: parameters)
    }
}
