//
//  AuthInterceptor.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

final class AuthInterceptor: NetworkInterceptor {

    private let tokenStore: TokenStoring
    
    init(tokenStore: TokenStoring) {
        self.tokenStore = tokenStore
    }
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        
        var newRequest = request
        
        if let accessToken = try await tokenStore.getAccessToken() {
            newRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return newRequest
    }
    
    func retry(_ request: URLRequest, dueTo error: any Error, attempt: Int) async throws -> Bool {
        false
    }
}
