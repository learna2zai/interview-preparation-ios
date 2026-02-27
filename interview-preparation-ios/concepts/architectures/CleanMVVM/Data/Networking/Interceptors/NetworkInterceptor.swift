//
//  NetworkInterceptor.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

protocol NetworkInterceptor {
    func adapt(_ request: URLRequest) async throws -> URLRequest
    func retry(_ request: URLRequest, dueTo error: Error, attempt: Int) async throws -> Bool
}
