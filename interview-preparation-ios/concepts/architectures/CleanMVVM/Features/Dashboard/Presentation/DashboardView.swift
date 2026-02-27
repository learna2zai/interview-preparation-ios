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
            .shimmer(dashboardViewModel.isLoading)
            .overlay(content: {
                if dashboardViewModel.users.isEmpty && !dashboardViewModel.isLoading {
                    ContentUnavailableView("No data to display.",
                                           systemImage: "person.bubble",
                                           description: Text("Please add some users to see them here."))
                }
//                else if dashboardViewModel.isLoading {
//                    ProgressView().controlSize(.large)
//                }
            })
            .onAppear {
                dashboardViewModel.trackScreenView()
                Task {
                    if dashboardViewModel.users.isEmpty {
                        await dashboardViewModel.fetchUserDetails()
                    }
                }
            }
            .navigationTitle("Dashboard")
    }
}

//#Preview {
//    DashboardView()
//}
