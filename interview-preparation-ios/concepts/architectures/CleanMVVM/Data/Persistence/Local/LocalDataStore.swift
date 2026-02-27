//
//  LocalDataStore.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation
import SwiftData

@Model
final class TaskEntity {
    @Attribute(.unique)
    var id: String
    
    var title: String
    var isCompleted: Bool
    var updatedAt: Date
    var syncStatus: SyncStatus
    
    init(id: String,
         title: String,
         isCompleted: Bool = false,
         updatedAt: Date = .now,
         syncStatus: SyncStatus = .synced) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.updatedAt = updatedAt
        self.syncStatus = syncStatus
    }
}

enum SyncStatus: String, Codable {
    case pending
    case synced
    case failed
}
