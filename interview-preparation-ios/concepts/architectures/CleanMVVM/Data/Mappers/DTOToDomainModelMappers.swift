//
//  DTOToDomainModelMappers.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

extension UserDTO {
    func toDomainModel() -> User {
        User(id: id, name: name, email: email)
    }
}
