//
//  SettingsView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import SwiftUI

struct SettingsView: View {
   
    @State private var settingsViewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.settingsViewModel = viewModel
    }
    
    var body: some View {
            Form {
                Section(header: Text("Settings")) {
                    Button("Logout") {
                        Task {
                            await settingsViewModel.logout()
                        }
                    }
                }
            }
            .onAppear {
                settingsViewModel.trackScreenView()
            }
    }
}

//#Preview {
//    let client = APIClient()
//    let authRepository = AuthRepositoryImpl(apiClient: client)
//    let logoutUseCase = LogoutUseCase(authRepository: authRepository)
//    let appViewModel = AppViewModel()
//    let viewModel = SettingsViewModel(usecase: logoutUseCase, appViewModel: appViewModel)
//    SettingsView(viewModel: viewModel)
//}
