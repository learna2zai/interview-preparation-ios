//
//  CustomViews.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct CustomViews: View {
    var body: some View {
        List {
            Section {
                NavigationLink("View Builder", destination: ViewBuilderExample())
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
