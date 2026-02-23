//
//  AnalyticsTracking.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation

protocol AnalyticsTracking {
    func track(_ event: AnalyticsEvents)
}
