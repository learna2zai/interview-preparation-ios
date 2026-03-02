//
//  MainCoordinator.swift
//  interview-preparation-ios
//
//  Created on 02/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import SwiftUI

@Observable
final class MainCoordinator {
    
    private let container: MainContainer
    
    init(container: AppContainer) {
        self.container = MainContainer(core: container.core)
    }
    
    func makeMainView() -> some View {
        TabView {
            Tab("Dashboard", systemImage: "house") {
                DashboardView(viewModel: container.makeDashboardViewModel())
            }
            
            Tab("Tasks", systemImage: "pencil.and.list.clipboard") {
                TaskListView(viewModel: container.makeTaskListViewModel())
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView(viewModel: container.makeSettingsViewModel())
            }
        }
    }
}
