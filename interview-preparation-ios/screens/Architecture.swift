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
            ScrollView(showsIndicators: false) {
                Grid(alignment: .top, horizontalSpacing: 16, verticalSpacing: 16, content: {
                    GridRow {
                        NavigationLink(value: ArchitectureRoutes.cleanArchitectureMVVM) {
                            GridItem(model: GridItemModel(title: "Clean Architecture + MVVM", description: "Clean architecture is a software design philosophy that separates data representation and business logic. \n\n Clean Architecture + MVVM combines strict layer separation with simple UI structuring. Core business logic lives in the Domain layer (Entities & UseCases), data access in the Data layer (Repositories & APIs), and the UI is handled by MVVM in the Presentation layer (View + ViewModel). \n\n This ensures scalability, testability, and independence from frameworks while keeping UI development fast and maintainable.")) {}
                        }
                    }
                    .foregroundStyle(.black)
                    
                    GridRow {
                        NavigationLink(value: ArchitectureRoutes.redux) {
                            GridItem(model: .init(title: "Redux Architecture", description: "Redux Architecture is a modern approach to building user interfaces with reactive data flows. \n\n It uses a single, predictable source of truth, called the state, and employs a unidirectional data flow, using actions as the primary means of communication between different parts of an application. \n\n Redux Architecture is widely used in modern web applications, including those built with frameworks like React, Angular, and Vue.js.")) {}
                        }
                    }
                    .foregroundStyle(.black)
                })
                .padding()
            }
            .navigationTitle("Architecture")
            .navigationDestination(for: ArchitectureRoutes.self) {
                switch $0 {
                    case .cleanArchitectureMVVM:
                        let container = AppDIContainer(.development, )
                        AppView(appViewModel: container.appViewModel, container: container)
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
