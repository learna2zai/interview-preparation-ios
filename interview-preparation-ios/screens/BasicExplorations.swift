//
//  BasicExplorations.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct BasicExplorations: View {
    @State private var searchQuery: String = ""
    
    var body: some View {
        List {
            Section(header: Text("Custom Views")) {
                NavigationLink("Background Color View", value: BasicExplorationsRoutes.customViews)
            }
            
            Section(header: Text("Architecture")) {
                NavigationLink("App Architecture", value: BasicExplorationsRoutes.architecture)
            }
            
            Section(header: Text("Local storage and Database")) {
                NavigationLink("Sqlite", value: BasicExplorationsRoutes.swiftData)
            }
            
            Section(header: Text("Swift Charts")) {
                NavigationLink("Charts", value: BasicExplorationsRoutes.swiftCharts)
            }
            
            Section(header: Text("Swift Package Manager")) {
                NavigationLink("SPM", value: BasicExplorationsRoutes.spm)
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchQuery)
                    .textFieldStyle(.plain)
                
                Image(systemName: "microphone")
            }
            .scrollDismissesKeyboard(.automatic)
            .padding()
            .glassEffect()
            .padding()
            
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Basic Explorations")
        .navigationSubtitle(Text("Basic Swift explorations and experiments for learning 👩‍🔬."))
        .navigationDestination(for: BasicExplorationsRoutes.self, destination: {
            switch $0 {
                case .customViews:
                    CustomViews()
                case .architecture:
                    Architecture()
                default:
                    ContentUnavailable()
            }
        })
    }
}

#Preview {
    BasicExplorations()
}
