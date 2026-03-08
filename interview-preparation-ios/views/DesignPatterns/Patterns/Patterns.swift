//
//  Patterns.swift
//  interview-preparation-ios
//
//  Created on 28/02/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI


let singlePrinciple = """
                /// MARK: - Singleton Pattern
                /// Use cases
                /// * Database connections
                /// * Logging
                /// * Configurations Access
                /// * Caching
                ///
                /// Implementations:
                ///     private intance
                ///     private constructor
                ///
                
                class Singletone {
                    static let shared = Singletone()
                    private init() {}
                }
                
                let someSingletoneInstance = Singletone.shared
                """

struct Patterns: View {
    var body: some View {
        List {
            
        }
        .navigationTitle(Text("Design Patterns"))
    }
}

#Preview {
    Patterns()
}
