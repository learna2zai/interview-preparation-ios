//
//  CoreContainer.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol CoreContainerProtocol {
    var environment: AppEnvironment { get }
    var analytics: AnalyticsTracking { get }
    var tokenStore: TokenStoring { get }
    var apiClient: APIClient { get }
}

final class CoreContainer: CoreContainerProtocol {

    let environment: AppEnvironment
    let analytics: AnalyticsTracking
    let tokenStore: TokenStoring

    private lazy var refreshTokenService: RefreshTokenServiceProtocol = {
        RefreshTokenService(tokenStore: tokenStore)
    }()

    lazy var apiClient: APIClient = {
        APIClient(
            baseUrl: environment.baseURL,
            interceptorPipeline: InterceptorPipeline(interceptors: []),
            refreshTokenService: refreshTokenService
        )
    }()

    init(
        environment: AppEnvironment,
        analytics: AnalyticsTracking,
        tokenStore: TokenStoring
    ) {
        self.environment = environment
        self.analytics = analytics
        self.tokenStore = tokenStore
    }
}
