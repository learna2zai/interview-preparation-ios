//
//  MockAnalytics.swift
//  interview-preparation-iosTests
//
//  Created by Ganesh on 24/02/26.
//

import Foundation
@testable import interview_preparation_ios

final class MockAnalytics: AnalyticsTracking {
    var trackedEvents: [AnalyticsEvents] = []
    
    func track(_ event: AnalyticsEvents) {
        trackedEvents.append(event)
    }
}
