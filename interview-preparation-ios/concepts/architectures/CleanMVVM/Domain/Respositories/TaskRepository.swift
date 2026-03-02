//
//  TaskRepository.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol TaskRepository {
    func observeTask() async throws -> [TaskEntity]
    func createTask(_ title: String) async throws
}
