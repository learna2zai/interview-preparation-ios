//
//  Architecture.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct Architecture: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Grid(alignment: .center, horizontalSpacing: 16, verticalSpacing: 16, content: {
                
                GridRow {
                    NavigationLink(value: ArchitectureRoutes.mvvm) {
                        GridItem(model: GridItemModel(title: "MVVM", description: "MVVM is a software design pattern that separates data representation and business logic.")) {}
                    }
                    
                    NavigationLink(value: ArchitectureRoutes.redux) {
                        GridItem(model: .init(title: "Redux", description: "Redux is a library for managing application state.")) {}
                    }
                }
                .foregroundStyle(.black)
                
                GridRow {
                    NavigationLink(value: ArchitectureRoutes.redux) {
                        GridItem(model: .init(title: "Clean", description: "Clean architecture is a software design philosophy that separates data representation and business logic.")) {}
                    }
                }
                .foregroundStyle(.black)
            })
            .padding()
            .navigationTitle("Architecture")
            .navigationDestination(for: ArchitectureRoutes.self) {
                switch $0 {
                    case .mvvm:
                        ContentUnavailable()
                    default:
                        ContentUnavailable()
                }
            }
        }
    }
}

#Preview {
    Architecture()
}
