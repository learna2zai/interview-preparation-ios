//
//  TaskRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation
import SwiftData

final class TaskRepositoryImpl {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Read
    
    func observeTask() throws -> [TaskEntity] {
        let descriptor = FetchDescriptor<TaskEntity>(sortBy: [SortDescriptor(\.updatedAt, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
    
    // MARK: - Create (offline first)
    
    func createTask(_ title: String) throws {
        let task = TaskEntity(id: UUID().uuidString, title: title, syncStatus: .pending)
        modelContext.insert(task)
        try modelContext.save()
    }
}
