//
//  Settings.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct Settings: View {
    
    @State private var isPushNotificationsOn: Bool = true
    @State private var isEmailNotificationOn: Bool = false
    @State private var isMobileNotificationOn: Bool = true
    
    private let appversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle("Push Notifications", isOn: $isPushNotificationsOn)
                    Toggle("Email Notifications", isOn: $isEmailNotificationOn)
                    Toggle("SMS Notifications", isOn: $isMobileNotificationOn)
                }
                
                Section {
                    NavigationLink(destination: ContentUnavailable()) {
                        Text("Privacy Policy")
                    }
                    NavigationLink(destination: ContentUnavailable()) {
                        Text("Help?")
                    }
                    
                    Button {
                        //
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .overlay(alignment: .bottom, content: {
                VStack {
                    Label("App Version: \(appversion) (\(buildVersion))", systemImage: "iphone")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
            })
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
