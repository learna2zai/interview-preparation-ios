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
                    NavigationLink("Background Color View", value: Routes.customViews)
                }
                
                Section(header: Text("Local storage and Database")) {
                    NavigationLink("Sqlite", value: Routes.swiftData)
                }
                
                Section(header: Text("Swift Charts")) {
                    NavigationLink("Charts", value: Routes.swiftCharts)
                }
                
                Section(header: Text("Swift Package Manager")) {
                    NavigationLink("SPM", value: Routes.spm)
                }
            }
            .navigationTitle("Basic Explorations")
            .navigationDestination(for: Routes.self, destination: {
                switch $0 {
                    case .customViews:
                        Text("Custom Views")
                    case .swiftData:
                        Text("Swift Data")
                    case .swiftCharts:
                        Text("Swift Charts")
                        
                    default:
                        Text("View not implemented")
                }
            })
        }
    }
}

#Preview {
    BasicExplorations()
}
