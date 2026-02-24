//
//  TaskSyncEngine.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation
import SwiftData

final class TaskSyncEngine {
    
    private let modelContext: ModelContext
    private let api: TaskAPI
    
    init(modelContext: ModelContext, api: TaskAPI) {
        self.modelContext = modelContext
        self.api = api
    }
    
    func syncPendingTasks() async throws {
        let pending = SyncStatus.pending
        let descriptor = FetchDescriptor<TaskEntity>(predicate: #Predicate<TaskEntity> { $0.syncStatus == pending})
        
        guard let pendingTasks: [TaskEntity] = try? modelContext.fetch(descriptor) else {
            return
        }
        
        for task in pendingTasks {
            do {
                let dto = TaskDTO(id: task.id,
                                  title: task.title,
                                  isCompleted: task.isCompleted,
                                  updatedAt: task.updatedAt)
                try await api.uploadTask(dto)
                task.syncStatus = SyncStatus.synced
            } catch {
                task.syncStatus = SyncStatus.failed
            }
        }
        try? modelContext.save()
    }
    
    // MARK: - Background Refresh
    
    func refreshFromRemote() async throws {
        let remoteTasks = try await api.fetchTasks()
        for dto in remoteTasks {
            upsertTask(dto)
        }
        try modelContext.save()
    }
    
    private func upsertTask(_ dto: TaskDTO) {
        
        // merge strategy (Last write wins)
        let descriptor = FetchDescriptor<TaskEntity>(predicate: #Predicate { $0.id == dto.id})
        
        if let existingTask = try? modelContext.fetch(descriptor).first {
            if dto.updatedAt > existingTask.updatedAt {
                existingTask.title = dto.title
                existingTask.isCompleted = dto.isCompleted
                existingTask.updatedAt = dto.updatedAt
                existingTask.syncStatus = SyncStatus.synced
            }
        } else {
            let newTask = TaskEntity(id: dto.id,
                                     title: dto.title,
                                     isCompleted: dto.isCompleted,
                                     updatedAt: dto.updatedAt,
                                     syncStatus: .synced)
            modelContext.insert(newTask)
        }
    }
    
}
