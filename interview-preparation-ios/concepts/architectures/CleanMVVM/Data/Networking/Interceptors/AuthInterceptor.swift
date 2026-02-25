//
//  AuthInterceptor.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 25/02/26.
//

import Foundation

final class AuthInterceptor: NetworkInterceptor {
    
    private let tokenProvider: () async -> String?
    
    init(tokenProvider: @escaping () async -> String?) {
        self.tokenProvider = tokenProvider
    }
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        
        var newRequest = request
        
        if let token = await tokenProvider() {
            newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return newRequest
    }
    
    func retry(_ request: URLRequest, dueTo error: any Error, attempt: Int) async throws -> Bool {
        false
    }
}
