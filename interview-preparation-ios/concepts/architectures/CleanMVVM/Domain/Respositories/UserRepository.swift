//
//  UserRepository.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

protocol UserRepository {
    func getUsers() async throws -> [User]
}
