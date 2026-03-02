//
//  UserRepository.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

protocol UserRepository {
    func createUser(user: User) async throws -> Bool
    func updateUser(userId: Int, user: User) async throws -> Bool
    func deleteUser(userId: Int) async throws -> Bool
    func deleteAllUsers() async throws -> Bool
    func getUser(userId: Int) async throws -> User
    func getUsers() async throws -> [User]
}
