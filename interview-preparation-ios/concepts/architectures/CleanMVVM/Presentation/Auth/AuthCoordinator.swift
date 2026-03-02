//
//  AuthCoordinator.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

@Observable
final class AuthCoordinator {
    
    private let container: AuthContainer
    
    var path = NavigationPath()
    
    init(container: AppContainer) {
        self.container = AuthContainer(core: container.core)
    }
    
    func makeView() -> some View {
        AuthFlowView(coordinator: self)
    }
    
    @ViewBuilder
    func showView(_ route: Route) -> some View {
        switch route {
            case .login:
                LoginView(viewModel: container.makeLoginViewModel(), coordinator: self)
            case .register:
                RegisterView(viewModel: container.makeRegisterViewModel(),
                             coordinator: self)
            case .forgotPassword:
                ContentUnavailable()
            case .basicExploration:
                BasicExplorations()
        }
    }
    
    enum Route: Hashable {
        case login
        case register
        case forgotPassword
        case basicExploration
    }
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
}
