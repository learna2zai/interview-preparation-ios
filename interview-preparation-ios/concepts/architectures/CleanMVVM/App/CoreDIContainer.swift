//
//  CoreDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class CoreDIContainer {
    
    let apiClient: APIClient
    
    lazy var analyticsService: AnalyticsTracking = {
        FirebaseAnalyticsService()
    }()
    
    init(environment: AppEnvironment) {
        switch environment {
            case .development:
                self.apiClient = APIClient(baseUrl: "https://jsonplaceholder.typicode.com/")
            case .staging:
                self.apiClient = APIClient(baseUrl: "https://jsonplaceholder.typicode.com/")
            case .production:
                self.apiClient = APIClient(baseUrl: "https://jsonplaceholder.typicode.com/")
        }
    }
}
