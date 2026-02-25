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
        var baseUrl: String = ""
        switch environment {
            case .development, .staging, .production:
                baseUrl = "https://jsonplaceholder.typicode.com/"
        }
        self.apiClient = APIClient(baseUrl: baseUrl,
                                   interceptorPipleline: InterceptorPipeline(interceptors: [LoggingInterceptor()]))
        
    }
}
