//
//  BackgroundTaskManager.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation
import BackgroundTasks

class BackgroundTaskManager {
    private let refreshIdentifire = "com.companyname.app.refresh"
    private let processingIdentifire = "com.companyname.app.processing"
    
    static let shared = BackgroundTaskManager()
    private init() {}
    
    // MARK: - Registration
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: refreshIdentifire, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: processingIdentifire, using: nil) { task in
            self.handleProcessing(task: task as! BGProcessingTask)
        }
    }
    
    // MARK: - Scheduling
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: refreshIdentifire)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh task: \(error)")
        }
    }
    
    func scheduleProcessing() {
        let request = BGProcessingTaskRequest(identifier: processingIdentifire)
        request.requiresExternalPower = false
        request.requiresNetworkConnectivity = true
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 30 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule processing task: \(error)")
        }
    }
    
    // MARK: - Task handlers
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        let workTask = Task {
            do {
                let posts = try await AsyncAwaitAPIs.shared.fetshPosts()
                // store data
                print(posts)
                task.setTaskCompleted(success: true)
            } catch {
                task.setTaskCompleted(success: false)
            }
        }
        
        task.expirationHandler = {
            workTask.cancel()
        }
    }
    
    func handleProcessing(task: BGProcessingTask) {
        scheduleProcessing()
        
        let queue = OperationQueue()
        let operation = ProcessingOperation()
        
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }
        
        queue.addOperation(operation)
    }
}

class ProcessingOperation: Operation, @unchecked Sendable {
    override func main() {
        if isCancelled { return }
        
//        do {
//            try someAsyncOperation() //
//        } catch {
//            print("Processing Error: \(error)")
//        }
    }
}
