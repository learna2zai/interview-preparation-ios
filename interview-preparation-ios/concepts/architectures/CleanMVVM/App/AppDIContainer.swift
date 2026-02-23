//
//  AppDIContainer.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation

final class AppDIContainer {
    
    let environment: AppEnvironment
    lazy var core = CoreDIContainer(environment: environment)
    
    // MARK: - App State
    let appViewModel = AppViewModel()
    
    init(_ environment: AppEnvironment) {
        self.environment = environment
    }
}
