import Foundation

// MARK: - Initialization

// It is the process of creating an instance of particular type(class, struct or enum).
// Init is special method to called to create new instance of a particular type, and this will not return anything.
// At the time of initialization all stored propertied get assigned initial values, and can't left in an intermediate state.

// For class instance a constant property can be modified during initialization only by the class that introduces it.It can not be modified by a subclass.


class Question {
    var text: String
    init(text: String) {
        self.text = text
    }
}

class MQQuestion: Question {
    var answer: String
    init(text: String, answer: String) {
        self.answer = answer
        super.init(text: text)
//        text = "Modified: \(text)" // Cannot assign to value: 'text' is a 'let' constant
    }
}

// Class has default initializer
// Struct has memberwise initializer

// Initializer Delegation for Value Types
// Innitializers can call other initializers to perform part of an instance's initialization.

// **When we define a custom initializer for a value type, we will no longer have access to the default initializer for that type.

// Swift defines two kinds of initializers for class types:
// - Designated - primary
// - Convenience - secondary

// ** Designated
// Every class must have atleast one designated initializer.

// ** Convenience initializers are secondary initializers supporting initializers for a class.
// We use `convenience` word before init syntax.

// Rules:

// Desig <-- Conve <-- Conve
//   |  \
//   |   \
// Desig  Desig <-- Conven

// ** We can't call a designated initializer from another in same class.

class Car {
    var speed: Int
    var color: String
    
    init(speed: Int, color: String) {
        self.speed = speed
        self.color = color
    }
    
    convenience init(color: String) {
//        self.color = color
//        self.speed = 0
        self.init(speed: 0, color: color)
    }
}

let car = Car(color: "Gray")

// Two Phase initialization



// Initializer Inheritance and Overriding

class Vehicle {
    var numberOfWheels: Int
    var description: String {
        "\(numberOfWheels) wheels"
    }
    
    init(numberOfWheels: Int = 0) async {
        self.numberOfWheels = numberOfWheels
    }
}


class BiCycle: Vehicle {
    override init(numberOfWheels: Int = 0) async {
        await super.init(numberOfWheels: numberOfWheels)
    }
}

let bicycle = await BiCycle()

// Subclass can modify inherited variable properties during initialization, but can't modify inheritated constant properties.

// A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.

// We can override a failable initializer with a nonfailable initializer but not the other way around.

// We don't have to provide an explicite implementation of a required initializer if you can satisfy the requirement with an inherited initializer.


