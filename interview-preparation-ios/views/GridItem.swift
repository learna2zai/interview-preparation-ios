//
//  GridItem.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct GridItemModel {
    var title: String
    var description: String
}

struct GridItemModifier: ViewModifier {
    
    // MARK: - environments values
    @Environment(\.designTokens) private var designTokens: DesignTokens
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: designTokens.cornerRadius(.medium))
                    .stroke(Color.gray, lineWidth: 1)
            }
    }
}

extension View {
    func gridItem() -> some View {
        self.modifier(GridItemModifier())
    }
}

struct GridItem<Contnet: View>: View {
    
    // MARK: - environments values
    @Environment(\.designTokens) private var designTokens: DesignTokens
    
    // MARK: - properties
    
    var model: GridItemModel
    var content: Contnet
    
    // MARK: - initialization
    
    init(model: GridItemModel, @ViewBuilder content: () -> Contnet) {
        self.model = model
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .center,spacing: designTokens.spacing(.regular)) {
            Text(model.title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(model.description)
                .font(.callout)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
            content
        }
        .gridItem()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GridItem(model: .init(title: "Grid Item",
                          description: "Some description about the grid item")
    ) {}
        .padding()
}
