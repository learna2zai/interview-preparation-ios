//
//  CoreDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class CoreDIContainer {
    
    let apiClient: APIClient
    let tokenStore = TokenStore()
    lazy var analyticsService = AnalyticsService()
    
    init(environment: AppEnvironment) {

        self.apiClient = APIClient(baseUrl: environment.baseURL,
                                   interceptorPipleline:
                                    InterceptorPipeline(interceptors: [
                                        AuthInterceptor(tokenStore: tokenStore),
                                        LoggingInterceptor()
                                    ]))
        
    }
}
