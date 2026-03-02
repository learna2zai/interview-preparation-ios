//
//  AuthFlowView.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

struct AuthFlowView: View {
    
    @State private var coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.showView(.login)
                .navigationDestination(for: AuthCoordinator.Route.self) { route in
                    coordinator.showView(route)
                }
        }
    }
}

//#Preview {
//    AuthFlowView()
//}
