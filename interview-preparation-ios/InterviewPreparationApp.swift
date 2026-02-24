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
            AppTabView()
                .onAppear {
                    BackgroundTaskManager.shared.scheduleAppRefresh()
                    BackgroundTaskManager.shared.scheduleProcessing()
                }
        }
//        .backgroundTask(.appRefresh("com.companyname.app.refresh")) {
//            Task {
//                do {
//                    let posts = try await AsyncAwaitAPIs.shared.fetshPosts()
//                    print(posts)
//                } catch {}
//            }
//        }
    }
}
