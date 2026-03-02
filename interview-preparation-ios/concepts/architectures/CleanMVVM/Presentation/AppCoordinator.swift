//
//  AppCoordinator.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation
import SwiftUI

@Observable
final class AppCoordinator {
    
    enum Flow {
        case auth
        case main
    }
    
    private let container = AppContainer(environment: .development)
    private var currentFlow: Flow = .auth
    
    @ViewBuilder
    func showView() -> some View {
        switch currentFlow {
            case .auth:
                AuthCoordinator(container: container).makeView()
            case .main:
                MainCoordinator(container: container).makeMainView()
        }
    }
    
    func show(_ flow: Flow) {
        currentFlow = flow
    }
}


protocol FlowActory {
    associatedtype FlowView: View
    func makeView() -> FlowView
}


struct AuthViewFactory: FlowActory {
    
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
    }
    
    func makeView() -> some View {
        AuthCoordinator(container: container)
            .makeView()
    }
}

struct MainViewFactory: FlowActory {
    
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
    }
    
    func makeView() -> some View {
        MainCoordinator(container: container)
            .makeMainView()
    }
}



