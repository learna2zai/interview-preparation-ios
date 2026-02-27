//
//  UserDTO.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let mobile: String?
    let status: Bool
    let createAt: String
    let updatedAt: String
}
