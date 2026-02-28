//
//  AnalyticsTracking.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation

protocol AnalyticsTracking: AnyObject {
    func track(_ event: AnalyticsEvents)
}
