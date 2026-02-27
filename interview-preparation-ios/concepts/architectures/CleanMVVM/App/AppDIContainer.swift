//
//  AppDIContainer.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation

final class AppDIContainer {
    
    let environment: AppEnvironment
    lazy var core = CoreDIContainer(environment: environment)
    
    // MARK: - App State
    lazy var appViewModel = AppViewModel(tokenStore: core.tokenStore)
    
    init(_ environment: AppEnvironment) {
        self.environment = environment
    }
}
