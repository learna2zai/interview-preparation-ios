//
//  SettingsView.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var settingsViewModel: SettingsViewModel
    
    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone
    
    
    var bounds: Range<Date> {
        let start = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 6))!
        let end = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 16))!
        return start ..< end
    }
    
    private let appversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    
    init(viewModel: SettingsViewModel) {
        self.settingsViewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Push Notifications", isOn: $settingsViewModel.isPushNotificationsOn)
                    Toggle("Email Notifications", isOn: $settingsViewModel.isEmailNotificationOn)
                    Toggle("SMS Notifications", isOn: $settingsViewModel.isMobileNotificationOn)
                }
                
                Section(header: Text("Appearance")) {
                    ColorPicker("Background Color", selection: $settingsViewModel.bgColor)
                    DatePicker("Select Date", selection: $settingsViewModel.date)
                    //                MultiDatePicker("Dates available", selection: $dates, in: bounds)
                }
                .headerProminence(.increased)
                
                
                Section {
                    NavigationLink(destination: ContentUnavailable()) {
                        Text("Privacy Policy")
                    }
                    NavigationLink(destination: ContentUnavailable()) {
                        Text("Help?")
                    }
                    
                    Button {
                        Task {
                            await settingsViewModel.logout()
                        }
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    if settingsViewModel.errorMessage != nil {
                        Label(settingsViewModel.errorMessage!, systemImage: "info.circle")
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("App Version: \(appversion) (\(buildVersion))")
                        Text("Copyright © \(Date().formatted(.dateTime.year())) All rights reserved.")
                        
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .listRowBackground(Color.clear)
                }
                .listSectionMargins(.vertical, 0)
            }
            .scrollIndicators(.hidden)
            .overlay(content: {
                if settingsViewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
            })
            .listSectionIndexVisibility(.visible)
            .navigationTitle("Settings")
            .onAppear {
                settingsViewModel.trackScreenView()
            }
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
