//: [Previous](@previous)

import Foundation

// MARK: - Closures

// Closure is self contained block of code that can be passed around and used in our code.
// Closures can capture and store references to variable and constant from the context they were defined.

// Points to remember:
// - Global functions are named closures and they don't capture any values.

let greet = {
    print("Hello, world!")
}

greet()

let withParameter: (String) -> String = { (name) -> String in
    print("Hello, \(name)")
    return "Hello, \(name)"
}

withParameter("User")

func withTralingClouser(_ complete: (String) -> Void) {
    complete("Hi")
}

withTralingClouser {
    let message = "\($0), Hello, world!"
    print(message)
}

func makeIncrementer(amount: Int) -> () -> Int {
    var total = 0
    let increment = {
        total += amount
        return total
    }
    return increment
}

let incremnetBy5 = makeIncrementer(amount: 5)
print(incremnetBy5())
print(incremnetBy5())
print(incremnetBy5())

let moreShorthandClouser: (String, Int, Double) -> Int = {
    print("\($0), \($1), \($2)")
    return 3
}

print(moreShorthandClouser("First", 1, 1.0))


func loadPicture(from server: String?, completion: (String) -> Void, onFailure: (String) -> Void) {
    
    if let server = server {
        print("Loading from \(server)")
        completion("Loaded from \(server)")
    } else {
        onFailure("Failed to load picture")
    }
}

loadPicture(from: "Some Sverver") { result in
    print(result)
} onFailure: { error in
    print(error)
}


// escaping clousers

var completionHandlers: [(String) -> Void] = []

@MainActor
func someFunctionWithEscapingClouser(completion: @escaping (String) -> Void) {
    completionHandlers.append(completion)
    //    completion("From the clouser")
}

//someFunctionWithEscapingClouser { value in
//    print(value)
//}

func someFunctionWithNonEscapingClouser(completion: () -> Void) {
    completion()
}

class SomeClass {
    var c = 10
    @MainActor
    func doSomeThing() {
        someFunctionWithEscapingClouser { [self] _ in
            c = 100
        }
        someFunctionWithNonEscapingClouser {
            c = 200
        }
    }
}

let instance = SomeClass()
instance.doSomeThing()
print(instance.c)

completionHandlers.first?("")

print(instance.c)

// Escaping clousers are used when the clouser is executed after the function retruns, usaually in async operations like networking, dispatchqueue or store callback.

class Person {
    let greeting = "Hi,"

    @MainActor
    func printName() {
        fetchData { name in
            print("\(self.greeting) \(name)")
        }
    }
}

@MainActor
func fetchData(completion: @escaping (String) -> Void) {
    DispatchQueue.main.async {
        completion("Anonymus")
    }
}


let person = Person()
person.printName()


class Person2 {
    var name: String = "Anonymus"
    
   lazy var printName: () -> Void = {
       print("Name: \(self.name)")
    }
    
    deinit {
        print("deinit called..!!")
    }
}

var person2: Person2? = Person2()
person2?.printName()

person2 = nil


// MARK: - Autoclosures

// An autoclosures automatically converts an expression into closure that is evaluated only when called, allowing cleaner syntax and lazy evaluation.

func replaceAnd(word: String, in text: String, ifPresent: @autoclosure () -> Bool) -> String {
    var textToEdit = text
    if ifPresent() {
        return textToEdit.replacingOccurrences(of: word, with: "&")
    }
    return textToEdit
}

let someText = "Hello, welcome!!!! and welcome to swift playground!"
let wordToReplace = "and"
let result = replaceAnd(word: wordToReplace, in: someText,
                               ifPresent: someText.range(of: "\\b\(wordToReplace)\\b",
                                                                   options: .regularExpression) != nil)
print(result)

let c = { () -> Bool in
    return "text andd more".range(of: "\\band\\b",
                                  options: .regularExpression) != nil
}
print(c())

func checkIfWordExist(in text: String, word: String) -> Bool {
    let pattern = "\\b\(word)\\b"
    return text.range(of: pattern, options: .regularExpression) != nil
}

func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("Logging value...!!!")
    }
}

logIfTrue(2 > 1 )

//: [Next](@next)

