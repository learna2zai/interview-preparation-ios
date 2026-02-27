//
//  Routes.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import Foundation

enum BasicExplorationsRoutes: String, CaseIterable {
    case customViews
    case swiftData
    case swiftCharts
    case spm
    case architecture
}

enum ArchitectureRoutes: String, CaseIterable {
    case cleanArchitectureMVVM
    case redux
}

enum AppPath: String, Hashable, CaseIterable {
    case basic
    case architecture
}
