//
//  CustomViews.swift
//  interview-preparation-ios
//
//  Created on 22/02/26.
//

import SwiftUI

struct CustomViews: View {
    var body: some View {
        List {
            Section {
                NavigationLink("View Builder", destination: ViewBuilderExample())
                NavigationLink("View Animations", destination: AnimationView())
            }
        }
        .navigationTitle(Text("Custom Views"))
    }
}

#Preview {
    NavigationStack {
        CustomViews()
    }
}
