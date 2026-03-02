//
//  TaskListUseCase.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class TaskListUseCase {
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func observeTask() async throws -> [TaskEntity] {
        try await taskRepository.observeTask()
    }
    
    func createTask(_ title: String) async throws {
        try await taskRepository.createTask(title)
    }
}
