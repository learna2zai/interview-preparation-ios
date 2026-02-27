//
//  InterceptorPipeline.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

final class InterceptorPipeline {
    private let interceptors: [NetworkInterceptor]
    
    init(interceptors: [NetworkInterceptor]) {
        self.interceptors = interceptors
    }
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        var adaptedRequest = request
        for interceptor in interceptors {
            adaptedRequest = try await interceptor.adapt(adaptedRequest)
        }
        return adaptedRequest
    }
    
    func shouldRetry(_ request: URLRequest, error: Error, attempt: Int) async throws -> Bool {
        for interceptor in interceptors {
            if try await interceptor.retry(request, dueTo: error, attempt: attempt) {
                return true
            }
        }
        return false
    }
}
