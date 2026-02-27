//
//  ResponseModel.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

typealias UserResponseModel = UserDTO

extension UserResponseModel {
    func toDTO() -> UserDTO {
        UserDTO(id: id, name: name, email: email, mobile: mobile, status: status, createAt: createAt, updatedAt: updatedAt)
    }
}

struct LoginResponseModel: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

struct LogoutResponseModel: Codable {
    let message: String
    let status: Bool
}
