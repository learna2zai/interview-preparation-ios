//
//  AppView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import SwiftUI
import Combine

struct AppView: View {
    
    @State var appViewModel: AppViewModel
    var container: AppDIContainer
    
    var body: some View {
        Group {
            switch appViewModel.currentRoute {
                case .login:
                    LoginDIContainer(core: container.core)
                        .makeLoginView(appState: appViewModel)
                case .dashboard:
                    mainTabView
                case .register:
                    RegisterDIContainer(core: container.core)
                        .makeRegisterView(appViewModel: appViewModel)
            }
        }
        .animation(.easeInOut, value: appViewModel.currentRoute)
    }
    
    private var mainTabView: some View {
        
        TabView {
            Tab {
                DashboardDIContainer(core: container.core).makeDashboardView()
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Dashboard")
                        .font(.caption)
                }
            }
            
            Tab {
                TasksDIContainer(core: container.core).makeTaskListView()
            } label: {
                VStack {
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("Tasks")
                        .font(.caption)
                }
            }
            
            Tab {
                SettingsDIContainer(core: container.core, appViewModel: appViewModel).makeSettingsView()
            } label: {
                 VStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    let container = AppDIContainer(.development)
    AppView(appViewModel: container.appViewModel, container: container)
}
