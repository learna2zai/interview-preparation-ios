//: [Previous](@previous)

import Foundation

// MARK: - Protocol, Protocol Extension.

protocol Animal {
    func makeSound() -> String
}

extension Animal {
    func makeSound() -> String {
        "Unknown sound"
    }
}

extension Animal {
    func run() -> String {
        "Running"
    }
}

struct Dog: Animal {
    func makeSound() -> String {
        "Woof!"
    }
    
    func run() -> String {
        "Dog Running fast"
    }
}

let dog: Animal = Dog()
print(dog.makeSound())
print(dog.run())


// MARK: - Static Dispatch vs Dynamic Dispatch

// MARK: - VTable(Virtual Table) vs Witness Table


//: [Next](@next)
