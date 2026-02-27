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
            if appViewModel.isLoading {
                ProgressView().controlSize(.large)
            } else {
                switch appViewModel.currentRoute {
                    case .register:
                        RegisterDIContainer(core: container.core)
                            .makeRegisterView(appViewModel: appViewModel)
                    case .login:
                        LoginDIContainer(core: container.core)
                            .makeLoginView(appState: appViewModel)
                    case .dashboard:
                        AppTabView(appViewModel: $appViewModel, container: container)
                        
                }
            }
        }
        .onAppear {
            Task {
                await appViewModel.checkLoggedInStatus()
            }
        }
        .animation(.easeInOut, value: appViewModel.currentRoute)
    }
}

#Preview {
    let container = AppDIContainer(.development)
    AppView(appViewModel: container.appViewModel, container: container)
}
