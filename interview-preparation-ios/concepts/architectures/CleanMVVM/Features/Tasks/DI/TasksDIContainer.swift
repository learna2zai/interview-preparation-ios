//
//  TasksDIContainer.swift
//  interview-preparation-ios
//
//  Created on 24/02/26.
//

import Foundation
import SwiftData

final class SwiftDataManager {
    
    var modelContext: ModelContext
    
    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: TaskEntity.self, configurations: configuration)
            self.modelContext = ModelContext(container)
        }
        catch {
            fatalError("Could not create model container Error: \(error.localizedDescription)")
        }
    }
}

final class TasksDIContainer {
    
    private var modelContext: ModelContext {
        SwiftDataManager().modelContext
    }
    
    private let core: CoreDIContainer
    private lazy var repository = TaskRepositoryImpl(modelContext: modelContext)
    
    init(core: CoreDIContainer) {
        self.core = core
    }
    
    func makeTaskListView() -> TaskListView {
        
        let viewModel = TaskListViewModel(taskRepository: repository,
                                          taskSyncEngine: TaskSyncEngine(modelContext: modelContext,
                                                                         api: TaskAPI()))
        return TaskListView(viewModel: viewModel)
    }
}
