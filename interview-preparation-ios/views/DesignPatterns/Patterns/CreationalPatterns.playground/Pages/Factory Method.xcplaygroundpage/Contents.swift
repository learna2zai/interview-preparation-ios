import Foundation

// MARK: -  Factory methods
// its a cdp that provide a interface to create objects without specifying their concreate classes.

// cons - more boilerplate code initially

protocol Shape {
    func draw()
}

protocol ShapeFactory {
    func makeShape() -> Shape
}

class Circle: Shape {
    func draw() {
        print("Circle drawn")
    }
}

class Rectangle: Shape {
    func draw() {
        print("Rectangle drawn")
    }
}

class CircleFactory: ShapeFactory {
    func makeShape() -> Shape {
        Circle()
    }
}

class RectangleFactory: ShapeFactory {
    func makeShape() -> Shape {
        Rectangle()
    }
}

func createShape(factoy: ShapeFactory) -> Shape {
    factoy.makeShape()
}

func drawShapes(with factories: [ShapeFactory]) {
    for factory in factories {
        let shape = factory.makeShape()
        shape.draw()
    }
}

class Square: Shape {
    func draw() {
        print("Square drawn")
    }
}

class SquareFactory: ShapeFactory {
    func makeShape() -> Shape {
        Square()
    }
}

drawShapes(with: [CircleFactory(), RectangleFactory(), SquareFactory()])

let circleShape = createShape(factoy: CircleFactory())
circleShape.draw()

//: [Previous](@previous) | [Next](@next)
