//
//  AppEnvironment.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

enum AppEnvironment: String, CaseIterable, Equatable {
    case development
    case staging
    case production
    
    var baseURL: String {
        switch self {
            case .development:
                return "https://jsonplaceholder.typicode.com/"
            case .staging:
                return "http://localhost:8080/api"
            case .production:
                return "https://api.github.com"
        }
    }
}
