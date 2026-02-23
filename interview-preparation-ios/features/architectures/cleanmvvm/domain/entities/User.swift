//
//  User.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String {
        name
    }
    let name: String
    let email: String
}

