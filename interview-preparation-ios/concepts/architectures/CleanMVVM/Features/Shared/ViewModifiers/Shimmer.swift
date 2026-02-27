//
//  Shimmer.swift
//  interview-preparation-ios
//
//  Created on 27/02/26.
//

import SwiftUI

struct ShimmerModifire: ViewModifier {
    
    @State private var isVisible: Bool = false
    var isShowing: Bool
    
    func body(content: Content) -> some View {
        if isShowing {
            content
                .redacted(reason: .placeholder)
                .opacity(isVisible ? 1 : 0.4)
                .onAppear {
                    withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: true)) {
                        isVisible.toggle()
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func shimmer(_ isShowing: Bool) -> some View {
        modifier(ShimmerModifire(isShowing: isShowing))
    }
}

private struct ShimmerModifier: ViewModifier {
    // Controls the horizontal phase of the shimmer stripe
    @State private var phase: CGFloat = -1.0

    // Customization
    var speed: Double
    var highlightWidth: CGFloat
    var baseOpacity: Double
    var highlightOpacity: Double

    func body(content: Content) -> some View {
        content
            .overlay(overlayMask(content: content))
            .mask(content)
            .onAppear {
                // Animate the phase from -1 to 2 so the stripe fully crosses the content
                withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
                    phase = 2.0
                }
            }
    }

    @ViewBuilder
    private func overlayMask(content: Content) -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let gradientWidth = max(width * highlightWidth, 16) // ensure visible minimum
            let x = (phase - 0.5) * width // phase maps across width

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.gray.opacity(baseOpacity),
                    Color.gray.opacity(highlightOpacity),
                    Color.gray.opacity(baseOpacity)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            // Make the gradient a narrow stripe and slide it horizontally
            .frame(width: gradientWidth)
            .offset(x: x)
        }
        .allowsHitTesting(false)
    }
}

public extension View {
    /// Applies a shimmer loading effect over the view.
    /// - Parameters:
    ///   - speed: Duration for the shimmer sweep across the view. Default 1.5s.
    ///   - highlightWidth: Fraction of the view's width used for the shimmering highlight (0-1). Default 0.3.
    ///   - baseOpacity: Opacity for the base gray areas. Default 0.3.
    ///   - highlightOpacity: Opacity for the highlight center. Default 0.6.
    func shimmer(
        speed: Double = 1.5,
        highlightWidth: CGFloat = 0.3,
        baseOpacity: Double = 0.3,
        highlightOpacity: Double = 0.6
    ) -> some View {
        modifier(
            ShimmerModifier(
                speed: speed,
                highlightWidth: highlightWidth,
                baseOpacity: baseOpacity,
                highlightOpacity: highlightOpacity
            )
        )
    }
}
