//
//  AppTabView.swift
//  interview-preparation-ios
//
//  Created on 22/02/26.
//

import SwiftUI

enum Tabs: String, Equatable, Hashable, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case dashboard
    case tasks
    case settings
    case search
    
    case sent
    case received
    case draft
}

struct AppTabView: View {
    @State private var isShowAccessory: Bool = true
    @State private var selectedTab: Tabs = .dashboard
    
    // Size classes is a trait that definesm the available spece in a dimension. Two type: Horizontal, Vertical
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var isSearchBarVisible: Bool = false
    @State private var searchQuery: String = ""
    @FocusState private var isSearchBarFocused: Bool
    
    @AppStorage("tab-customization")
    private var customization: TabViewCustomization = .init()
    
    @Binding var appViewModel: AppViewModel
    var container: AppDIContainer
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab("Dashboard", systemImage: "house", value: .dashboard) {
                NavigationStack {
                    DashboardDIContainer(core: container.core).makeDashboardView()}
            }
            .customizationID("com.myApp.dashboard")
            
            Tab("Tasks", systemImage: "pencil.and.list.clipboard", value: .tasks) {
                NavigationStack {
                    TasksDIContainer(core: container.core).makeTaskListView()
                }
            }
            .customizationID("com.myApp.tasks")
            
            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsDIContainer(core: container.core, appViewModel: appViewModel).makeSettingsView()
            }
            .customizationID("com.myApp.settings")

//            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {}
//                .customizationID("com.myApp.search")
            
            TabSection("Messages") {
                Tab("Received", systemImage: "tray.and.arrow.down.fill", value: Tabs.received) {
                    Text("Received")
                }
                .customizationID("com.myApp.message.received")
                
                
                Tab("Sent", systemImage: "tray.and.arrow.up.fill", value: .sent) {
                    Text("Sent")
                }
                .customizationID("com.myApp.message.sent")
                
                
                Tab("Drafts", systemImage: "pencil", value: .draft) {
                    Text("Dasftsss")
                }
                .customizationID("com.myApp.message.draft")
            }
            .hidden(sizeClass != .regular)
            .customizationID("com.myApp.messages")
        }
//        .tabViewBottomAccessory(isEnabled: selectedTab == .home) {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Search", text: $searchQuery)
//                    .focused($isSearchBarFocused)
//                Image(systemName: "microphone")
//            }
//            .padding()
//            .background(.ultraThinMaterial)
//        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
    }
}

//#Preview {
//    AppTabView()
//}
