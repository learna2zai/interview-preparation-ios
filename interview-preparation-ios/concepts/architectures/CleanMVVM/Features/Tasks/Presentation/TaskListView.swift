//
//  TaskListView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @State private var viewModel: TaskListViewModel
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(viewModel.tasks) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    if task.syncStatus == SyncStatus.pending {
                        Text("⏳")
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            HStack {
                TextField("Task Title", text: $viewModel.title)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add") {
                    Task {
                        if viewModel.title.isEmpty { return }
                        await viewModel.addTask()
                        viewModel.title = ""
                    }
                }
                Button("Refresh") {
                    Task {
                        await viewModel.refresh()
                    }
                }
            }
            .padding(20)
        }
        .onAppear {
            Task {
                await viewModel.refresh()
            }
        }
    }
}

//#Preview {
//    TaskListView()
//}
