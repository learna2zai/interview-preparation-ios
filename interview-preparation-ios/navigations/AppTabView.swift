//
//  AppTabView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            Tab {
                BasicExplorations()
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.title)
                }
            }
            
            Tab {
                Architecture()
            } label: {
                VStack {
                    Image(systemName: "xmark.triangle.circle.square")
                    Text("Architecture")
                }
            }
            
            Tab {
                Settings()
            } label: {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}

#Preview {
    AppTabView()
}
