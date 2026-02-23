//
//  LoginResponse.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let refreshToken: String
}
