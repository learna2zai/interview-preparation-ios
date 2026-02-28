//
//  TaskListViewModel.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation
import Combine

@Observable
final class TaskListViewModel {
    
    private let taskRepository: TaskRepositoryImpl
    private let taskSyncEngine: TaskSyncEngine
    
    var title: String = ""
    var tasks: [TaskEntity] = []
    
    init(taskRepository: TaskRepositoryImpl, taskSyncEngine: TaskSyncEngine) {
        self.taskRepository = taskRepository
        self.taskSyncEngine = taskSyncEngine
    }
    
    func addTask() async {
        do {
            try taskRepository.createTask(title)
            await refresh()
        } catch {
            print("Handle Error \(error.localizedDescription)")
        }
    }
    
    func refresh() async {
        do {
            tasks = try taskRepository.observeTask()
            try await taskSyncEngine.refreshFromRemote()
            try await taskSyncEngine.syncPendingTasks()
        } catch {
            print("Handle Error \(error.localizedDescription)")
        }
    }
}
