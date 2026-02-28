//
//  OpenClosed.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

struct OpenClosed: SolidPrincipleProtocol {
    
    let title = "OpenClosed Principle"
    let description = "Open Closed principle states that software entities should be open for extenion but clossed for modification."
    
    let problem = """
// MARK: - Open-Close

class Shape {
    var type: String
    
    init(type: String) {
        self.type = type
    }
}

class AreaCalculator {
    func calculateArea(shape: Shape) -> Double {
        if shape.type == "Circle" {
            return 3.14 * 100.0
        } else if shape.type == "Square" {
            return 100.0 * 100.0
        }
        return 0.0
    }
}

/// voilates open close rule
"""
    
    let resolution = """
// create a protocol which type can confirm

protocol ShapeProtocol {
    func calculateArea() -> Double
}

class Circle: ShapeProtocol {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func calculateArea() -> Double {
        return 3.14 * radius
    }
}

class Square: ShapeProtocol {
    var side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    func calculateArea() -> Double {
        return side * side
    }
}

///  independent method to calculate are without knowing for what shape it is calculating

func calculateShapeArea(shape: ShapeProtocol) -> Double {
    shape.calculateArea()
}
"""
    
}
