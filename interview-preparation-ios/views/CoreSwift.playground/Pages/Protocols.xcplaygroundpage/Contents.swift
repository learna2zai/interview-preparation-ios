//: [Previous](@previous)

import Foundation
import PlaygroundSupport

// MARK: - Protocol, Protocol Extension.

// Properties in protocol

// always declare type properties with static

@MainActor
protocol SomeProtocol {
    var name: String { get }
    static var someStaticProperty: String { get }
    static var someClassProperty: String { get }
    
    static func someStaticFunction() -> String
    func someInstanceFunction() -> String
    static func someClassFunction() -> String
    
    init()
    mutating func toggle()
}

class SomeClass: SomeProtocol {
    var name: String
    static let someStaticProperty: String = "Static Property Value"
    class var someClassProperty: String  { "Class Property Value" }
    
    init(name: String) {
        self.name = name + "!!"
//        SomeClass.someStaticProperty = "Modified Static Property Value"
    }
    
    required init() {
        name = "Default Name"
    }
}

extension SomeClass: Sendable {
    static func someStaticFunction() -> String { "Static Function Value" }
    func someInstanceFunction() -> String { "Instance Function Value" }
    class func someClassFunction() -> String { "Class Function Value" }
    
    func toggle() {
        name.append(" toggled")
    }
}


SomeClass.someStaticProperty
//SomeClass.someStaticProperty = ""
SomeClass.someStaticProperty
let classInstance = SomeClass(name: "Some Name")
SomeClass.someStaticProperty

struct SomeStruct: SomeProtocol {
    
    var name: String
    static var someStaticProperty: String = "Static Property Value"
    static var someClassProperty: String = "Class Property Value"
    
    init(name: String) {
        self.name = name
    }

    init() {
        name = "Default Name"
    }
}

let structInstance = SomeStruct(name: "Some Name")

MemoryLayout.size(ofValue: structInstance)

extension SomeStruct {
    static func someStaticFunction() -> String { "Static Function Value" }
    func someInstanceFunction() -> String { "Instance Function Value" }
    static func someClassFunction() -> String { "Class Function Value" }
    mutating func toggle() {
        name = "\(name) toggled"
    }
}

enum SomeEnum: SomeProtocol {
    case first(name: String)
    var name: String {
        switch self {
            case .first(let name):
                return name
        }
    }
    static var someStaticProperty: String = "Static Property Value"
    static var someClassProperty: String = "Class Property Value"
    
    init() {
        self = .first(name: "Default Name")
    }
}

extension SomeEnum {
    static func someStaticFunction() -> String {
        "Static Funtion Value"
    }
    
    func someInstanceFunction() -> String {
        "Some instance method"
    }
    
    static func someClassFunction() -> String {
        "Some class function"
    }
    mutating func toggle() {
        self = .first(name: "\(name) toggled")
    }
}

let someEnum = SomeEnum()
someEnum.name


//

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


protocol SomePlaceProtocol {
    associatedtype Place  // kind of placeholder type for protocol and in confirming type the actual value will be provided
    func describe(place: Place) -> String
}

struct City: SomePlaceProtocol {
    typealias Place = String
    func describe(place: String) -> String {
        ""
    }
}

// MARK: - Static Dispatch vs Dynamic Dispatch

// MARK: - VTable(Virtual Table) vs Witness Table


//: [Next](@next)
