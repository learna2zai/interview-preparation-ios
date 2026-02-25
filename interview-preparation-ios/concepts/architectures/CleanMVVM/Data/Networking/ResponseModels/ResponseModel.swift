//
//  ResponseModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 25/02/26.
//

import Foundation

typealias UserResponseModel = UserDTO

extension UserResponseModel {
    func toDTO() -> UserDTO {
        UserDTO(id: id, name: name, email: email)
    }
}
