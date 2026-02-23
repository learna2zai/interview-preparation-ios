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
    var container: DependencyContainer
    
    var body: some View {
        Group {
            switch appViewModel.currentRoute {
                case .login:
                    container.makeLoginView()
                case .dashboard:
                    mainTabView
            }
        }
        .animation(.easeInOut, value: appViewModel.currentRoute)
    }
    
    private var mainTabView: some View {
        TabView {
            Tab {
                container.makeDashboardView()
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Dashboard")
                        .font(.caption)
                }
            }
            
            Tab {
                container.makeSettingsView()
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
    let container = DependencyContainer()
    AppView(appViewModel: container.appViewModel, container: container)
}
