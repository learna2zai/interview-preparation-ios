//
//  CoreDIContainer.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class CoreDIContainer {
    
    let apiClient: APIClient
    let tokenStore = TokenStore()
    lazy var analyticsService = AnalyticsService()
    let appSession: AppSession = .init()
    
    init(environment: AppEnvironment) {

        self.apiClient = APIClient(baseUrl: environment.baseURL,
                                   appSession: appSession,
                                   interceptorPipleline:
                                    InterceptorPipeline(interceptors: [
                                        AuthInterceptor(tokenStore: tokenStore),
                                        LoggingInterceptor()
                                    ]),
                                   refreshTokenService: RefreshTokenService(tokenStore: tokenStore))
        
    }
}
