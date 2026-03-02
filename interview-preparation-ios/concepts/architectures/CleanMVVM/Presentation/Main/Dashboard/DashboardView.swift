//
//  DashboardView.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var dashboardCoordinator = DashboardCoordinator()
    @State private var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $dashboardCoordinator.path) {
            List {
                ForEach(viewModel.dashboardData.reports, id: \.id) { report in
                    VStack(alignment: .leading) {
                        Text(report.title)
                            .font(.headline)
                        
                        Text("\(report.count)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .shimmer(viewModel.isLoading)
            .overlay(content: {
                if viewModel.dashboardData.reports.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                    ContentUnavailableView("No data to display.",
                                           systemImage: "person.bubble",
                                           description: Text("Please add some users to see them here."))
                }
                else if !viewModel.isLoading {
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            })
            .onAppear {
                viewModel.trackScreenView()
                Task {
                    if viewModel.dashboardData.reports.isEmpty {
                        await viewModel.fetchDetails()
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

//#Preview {
//    DashboardView()
//}
