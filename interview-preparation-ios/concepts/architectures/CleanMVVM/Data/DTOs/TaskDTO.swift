//
//  TaskDTO.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation

struct TaskDTO: Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let updatedAt: Date
}
