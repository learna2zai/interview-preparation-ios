//
//  InterviewPreparationApp.swift
//  interview-preparation-ios
//
//  Created on 22/02/26.
//

import SwiftUI

@main
struct InterviewPreparationApp: App {
    
    @State var coordinator = AppCoordinator()
    
//    init() {
//        BackgroundTaskManager.shared.registerBackgroundTasks()
//    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.showView()
                .environment(coordinator)
//                .onAppear {
//                    BackgroundTaskManager.shared.scheduleAppRefresh()
//                    BackgroundTaskManager.shared.scheduleProcessing()
//                }
        }
    }
}
