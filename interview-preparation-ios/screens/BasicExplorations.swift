//
//  BasicExplorations.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct BasicExplorations: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section(header: Text("Custom Views")) {
                    NavigationLink("Background Color View", value: BasicExplorationsRoutes.customViews)
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
            .navigationTitle("Basic Explorations")
            .navigationDestination(for: BasicExplorationsRoutes.self, destination: {
                switch $0 {
                    case .customViews:
                        CustomViews()
                        
                    default:
                        ContentUnavailable()
                }
            })
        }
    }
}

#Preview {
    BasicExplorations()
}
