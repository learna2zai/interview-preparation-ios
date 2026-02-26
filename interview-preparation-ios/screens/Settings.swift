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
    @State private var bgColor: Color = .blue
    @State private var date: Date = Date()
    
    @State private var dates: Set<DateComponents> = []
    
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
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Push Notifications", isOn: $isPushNotificationsOn)
                    Toggle("Email Notifications", isOn: $isEmailNotificationOn)
                    Toggle("SMS Notifications", isOn: $isMobileNotificationOn)
                }
                .sectionIndexLabel(Text("More"))
                
                Section(header: Text("Appearance")) {
                    ColorPicker("Background Color", selection: $bgColor)
                    DatePicker("Select Date", selection: $date)
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
                        //
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!)
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
            .listSectionIndexVisibility(.visible)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
