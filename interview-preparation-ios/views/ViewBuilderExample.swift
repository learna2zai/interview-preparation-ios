//
//  ViewBuilderExample.swift
//  interview-preparation-ios
//
//  Created on 22/02/26.
//

import SwiftUI

struct CardView<Content: View>: View {
    
    @Environment(\.designTokens) private var tokens: DesignTokens
    
    var title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: "text.pad.header")
                .font(.title2)
            Divider()
            content
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius(.regular))
                .stroke(Color.gray)
               
        }
        .shadow(radius: tokens.cornerRadius(.small))
        .padding()
    }
}

struct ViewBuilderExample: View {
    var body: some View {
        VStack {
            CardView(title: "Card") {
                Text("Here you can put anything")
                    .font(.title)
                Text("This is a card")
                    .font(.callout)
            }
        }
        .navigationBarTitle("View Builder")
    }
}

#Preview {
    ViewBuilderExample()
}
