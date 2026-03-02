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
    
    private let taskListUseCase: TaskListUseCase
//    private let taskSyncEngine: TaskSyncEngine
    
    var title: String = ""
    var tasks: [TaskEntity] = []
    
    init(taskListUseCase: TaskListUseCase
//         , taskSyncEngine: TaskSyncEngine
    ) {
        self.taskListUseCase = taskListUseCase
//        self.taskSyncEngine = taskSyncEngine
    }
    
    func addTask() async {
        do {
            try await taskListUseCase.createTask(title)
            await refresh()
        } catch {
            print("Handle Error \(error.localizedDescription)")
        }
    }
    
    func refresh() async {
        do {
            tasks = try await taskListUseCase.observeTask()
//            try await taskSyncEngine.refreshFromRemote()
//            try await taskSyncEngine.syncPendingTasks()
        } catch {
            print("Handle Error \(error.localizedDescription)")
        }
    }
}
