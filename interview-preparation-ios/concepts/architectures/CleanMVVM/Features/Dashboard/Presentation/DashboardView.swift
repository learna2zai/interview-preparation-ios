//
//  DashboardView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var dashboardViewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.dashboardViewModel = viewModel
    }
    
    var body: some View {
        
        List {
            ForEach(dashboardViewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .overlay(content: {
            if dashboardViewModel.users.isEmpty && !dashboardViewModel.isLoading {
                ContentUnavailable()
            } else if dashboardViewModel.isLoading {
                ProgressView().controlSize(.large)
            }
        })
        .onAppear {
            dashboardViewModel.trckScreenView()
            Task {
                await dashboardViewModel.fetchUserDetails()
            }
        }
        .navigationTitle(Text("Dashboard"))
    }
}

//#Preview {
//    DashboardView()
//}
