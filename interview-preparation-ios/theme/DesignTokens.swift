//
//  DesignTokens.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import Foundation

struct DesignTokens {
    
    enum Color {
        case primary
        case secondary
        case tertiary
    }
    
    enum Font {
        case title
        case body
    }
    
    enum Image {
        case logo
    }
    
    enum Border {
        case thin
    }
    
    enum Spacing: Double {
        case extrasmall = 4
        case small = 8
        case medium = 12
        case regular = 16
        case large = 20
        case extraLarge = 24
    }
    
    enum CornerRadius: Double {
        case extrasmall = 4
        case small = 8
        case medium = 12
        case regular = 16
        case large = 20
        case extraLarge = 24
    }
}

extension DesignTokens {
    func cornerRadius(_ size: CornerRadius) -> Double {
        size.rawValue
    }
    
    func color(_ color: DesignTokens.Color) -> String {
        color.value
    }
    
    func spacing(_ size: Spacing) -> Double {
        size.rawValue
    }
}

extension DesignTokens.Color {
    var value: String {
        switch self {
            case .primary:
                return "#007AFF"
            case .secondary:
                return "#000000"
            case .tertiary:
                return "#FFFFFF"
        }
    }
}
