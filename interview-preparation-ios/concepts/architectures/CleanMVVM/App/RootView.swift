//
//  RootView.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        Text("")
//        coordinator.showView
//            .environment(coordinator)
    }
}

//#Preview {
//    RootView()
//}
