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
        Text("Hello, World!")
            .onAppear {
                dashboardViewModel.trckScreenView()
            }
    }
}

//#Preview {
//    DashboardView()
//}
