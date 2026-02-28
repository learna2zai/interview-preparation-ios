//
//  ConvertAPIRequest.swift
//  interview-preparation-ios
//
//  Created on 27/02/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

struct ConvertAPIRequest {
    
    func convertToRequest(_ baseUrl: String, request: APIRequest) throws -> URLRequest {
        guard let url = URL(string: baseUrl),
              var urlComponents = URLComponents(url: url.appendingPathComponent(request.path),
                                                resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = request.queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = 30.0
        
        request.headers.forEach({ urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) })
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}


