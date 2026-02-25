//
//  LoggingInterceptor.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 25/02/26.
//

import Foundation

final class LoggingInterceptor: NetworkInterceptor {
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        print("Request: \(request.url?.absoluteString ?? "")")
        return request
    }
    
    func retry(_ request: URLRequest, dueTo error: any Error, attempt: Int) async throws -> Bool {
        print("Retry Attempt: \(attempt)")
        return true
    }
}
