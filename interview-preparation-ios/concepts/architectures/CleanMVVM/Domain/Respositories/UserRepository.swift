//
//  UserRepository.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

protocol UserRepository {
    func getUsers() async throws -> [User]
}
