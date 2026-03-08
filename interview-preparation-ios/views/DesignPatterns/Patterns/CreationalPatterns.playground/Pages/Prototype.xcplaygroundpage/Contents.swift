import Foundation

// MARK: - Prototype Pattern

// its a cdp allows to cloning objects, without coulping to specific classes.

// usecase
// - object creation expensive
// - when we need similar objects

protocol Cloneable {
    func clone() -> Self
}

class CircleShape: Cloneable {
    var radius: Int
    var color: String = "red"
    
    required init(radius: Int, color: String) {
        self.radius = radius
        self.color = color
    }
    
    func clone() -> Self {
        return type(of: self).init(radius: radius, color: color)
    }
}

let redCircle = CircleShape(radius: 10, color: "red")
let clonedRedCircle = redCircle.clone()
clonedRedCircle.color = "blue"
clonedRedCircle.radius = 20

let anotherRed = redCircle
anotherRed.color = "green"

print(anotherRed === redCircle)
print(redCircle === clonedRedCircle)


//: [Previous](@previous) | [Next](@next)
