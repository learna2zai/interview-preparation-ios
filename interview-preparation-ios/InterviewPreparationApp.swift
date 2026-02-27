//
//  InterviewPreparationApp.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

@main
struct InterviewPreparationApp: App {
    init() {
        BackgroundTaskManager.shared.registerBackgroundTasks()
    }
    
    var body: some Scene {
        WindowGroup {
            let container = AppDIContainer(.staging)
            AppView(appViewModel: container.appViewModel, container: container)
                .onAppear {
                    BackgroundTaskManager.shared.scheduleAppRefresh()
                    BackgroundTaskManager.shared.scheduleProcessing()
                }
        }
    }
}
