//
//  AuthRepository.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async throws -> Bool
    func register(name: String, email: String, password: String) async throws -> Bool
    func logout() async throws -> Bool
}
