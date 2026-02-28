//
//  SOLID.swift
//  interview-preparation-ios
//
//  Created on 28/02/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

protocol SolidPrincipleProtocol {
    var title: String { get }
    var description: String { get }
    var problem: String { get }
    var resolution: String { get }
}

struct CodeBlockViewModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .font(.system(.body, design: .serif))
            .padding()
            .background(.gray.opacity(0.05))
            .clipShape(.rect(cornerRadius: 8))
            .padding(.leading, -24)
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func makeCodeBlock() -> some View {
        modifier(CodeBlockViewModifire())
    }
}

struct SourceCodeBlockView: View {
    
    let attributedQText: AttributedString
    let attributedAText: AttributedString
    
    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading) {
                Text(attributedQText)
                    .makeCodeBlock()
                    .foregroundStyle(.blue)
                
                Label("Solution", systemImage: "questionmark.circle")
                    .padding(.vertical)
                
                Text(attributedAText)
                    .makeCodeBlock()
                    .foregroundStyle(.green)
                
            }
        } label: {
            Label("Source Code", systemImage: "arrow.2.circlepath.circle")
        }
    }
}

struct SOLID: View {
    
    let principles: [any SolidPrincipleProtocol] = [SingleResponsibility(), OpenClosed(), LiskovSubstitution(), InterfaceSegregation(), DependencyInversion()]
    
    var body: some View {
        List {
            ForEach(principles, id: \.title) { principle in
                Section(header: Text(makeFirstCharBold(of: principle.title)).font(.title2)) {
                    
                    Text(principle.description)
                        .foregroundStyle(.secondary)
                    
                    SourceCodeBlockView(attributedQText: AttributedString(principle.problem),
                                attributedAText: AttributedString(principle.resolution))
                }
            }
        }
        .navigationTitle(Text("SOLID Principles"))
    }
}

#Preview {
    NavigationStack {
        SOLID()
    }
}
