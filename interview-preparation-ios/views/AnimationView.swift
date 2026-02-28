//
//  AnimationView.swift
//  interview-preparation-ios
//
//  Created on 26/02/26.
//

import SwiftUI

struct AnimationView: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button("Sample") {
                
            }
            .padding()
//            .buttonStyle(.borderedProminent)
            .glassEffect()
            
            
            Text("Text Check")
                .font(.title2)
                .padding()
                .glassEffect()
            
            if isAnimating {
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .padding()
                    .transition(.blurReplace)
            }
            
//            GlassEffectContainer(spacing: 20) {
                HStack(spacing: 20) {
                    
                    Button("Toggle") {
                        withAnimation(.easeInOut) {
                            isAnimating.toggle()
                        }
                        
                    }
                    .padding(8)
                    .glassEffect()
                    
                    Menu {
                        Button("Open in Preview", action: openInPreview)
                        Button("Save as PDF", action: saveAsPDF)
                    } label: {
                        Label("PDF", systemImage: "doc.fill")
                    }
                    .padding(8)
                    .glassEffect()
                    
                    .offset(x: -20, y: 0)
                }
                .padding()
                .glassEffect()
                .offset(x: 40)
//                .clipped()
                
                .zIndex(2)
//                .visualEffect { content, proxy in
//                    content.offset(CGSize(width: -100, height: 40))
//                }
//            }
            
            
            ZStack {
                Circle()
                    .fill(Gradient(colors: [.brown, .yellow]))
//                    .stroke(Color.red.opacity(0.4), lineWidth: 2)
                    .frame(width: 100)
                    
                    Text("iOS")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(.white)
            }
            .padding(4)
            .glassEffect()
            
        }
//        .mask {
//            Rectangle().opacity(0.3)
//        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.gray)
        
    }
    
    func openInPreview() {
        
    }
    func saveAsPDF() {
        
    }
}

#Preview {
    AnimationView()
}
