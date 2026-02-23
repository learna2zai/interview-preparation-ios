//
//  AuthRepository.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async throws
    func register(name: String, email: String, password: String) async throws
    func logout() async throws
}
