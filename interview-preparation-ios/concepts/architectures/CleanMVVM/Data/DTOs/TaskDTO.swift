//
//  TaskDTO.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation

struct TaskDTO: Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let updatedAt: Date
}
