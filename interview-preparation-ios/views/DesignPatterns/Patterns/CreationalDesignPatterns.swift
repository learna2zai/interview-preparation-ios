//
//  CreationalDesignPatterns.swift
//  interview-preparation-ios
//
//  Created on 07/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation


// MARK: - Singleton Pattern

final class SingletonClass {
    static let shared = SingletonClass()
    private init() {}
}

// usese case netwk, db conn, cache, config, logger
// its a cdp ensure that a class has only one instance, by providing global access point to this instance.

// MARK: - Factory Method

protocol Shape {
    func draw()
}

protocol ShapeFactory {
    func makeShape() -> Shape
}

class CircleShape: Shape {
    func draw() {
        print("Drawing Circle")
    }
}

class Rectangle: Shape {
    func draw() {
        print("Drawing Rectangle")
    }
}

class CircleFactory: ShapeFactory {
    func makeShape() -> Shape {
        return CircleShape()
    }
}

class RectangleFactory: ShapeFactory {
    func makeShape() -> Shape {
        return Rectangle()
    }
}

func drawShapes(with factories: [ShapeFactory]) {
    for factory in factories {
        let shape = factory.makeShape()
        shape.draw()
    }
}

//drawShapes(with: [CircleFactory(), RectangleFactory()])

//protocol Shape {
//    func draw()
//}
//
//protocol ShapeFactory {
//    func makeShape() -> Shape
//}
//
//class Rectangle: Shape {
//    func draw() {
//        print("Drawing Rectangle")
//    }
//}
//
//class Circle: Shape {
//    func draw() {
//        print("Drawing Circle")
//    }
//}
//
//class RectangleFactory: ShapeFactory {
//    func makeShape() -> Shape {
//        return Rectangle()
//    }
//}
//
//class CircleFactory: ShapeFactory {
//    func makeShape() -> Shape {
//        return Circle()
//    }
//}
//
//func drwaShapes(factories: [ShapeFactory]) {
//    for factory in factories {
//        let shape = factory.makeShape()
//        shape.draw()
//    }
//}


