//
//  DesignPatterns.swift
//  interview-preparation-ios
//
//  Created on 28/02/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct DesignPatterns: View {
    var body: some View {
        List {
            NavigationLink(destination: SOLID()) {
                Text("SOLID Principles")
            }
            
            NavigationLink(destination: Patterns()) {
                Text("Patterns")
            }
        }
        .navigationTitle(Text("Design Patterns"))
    }
}

#Preview {
    NavigationStack {
        DesignPatterns()
    }
}
