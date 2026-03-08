//: [Previous](@previous)

import Foundation

//MARK: - Stack implementation

// write a for stack implementation using array

// Last in. first out

struct Stack<Element> {
    
    private var elements: [Element] = []
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop() -> Element? {
        elements.popLast()
    }
    
    func peek() -> Element? {
        elements.last
    }
    
    func isEmpty() -> Bool {
        elements.isEmpty
    }
}

var stack = Stack<Int>()
stack.push(4)
stack.push(5)
stack.push(6)
stack.push(7)

stack.pop()
stack.peek()?.description
stack.isEmpty().description


// arrays often used as stack, cuase it supports append and poplast() efficiently.

class Node<Element> {
    let value: Element
    var next: Node<Element>?
    
    init(value: Element, next: Node<Element>? = nil) {
        self.value = value
        self.next = next
    }
}

func showValues<T>(_ node: Node<T>) -> String {
    var currentNode: Node<T>? = node
    var str = ""
    while let node = currentNode {
        str += "\(node.value) \(node.next != nil ? "-> ": "")"
        currentNode = node.next
    }
    return str
}

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(showValues(node1))


struct LinkedStack<T> {
   private var top: Node<T>? = nil
    
    mutating func push(_ value: T) {
        top = Node(value: value, next: top)
    }
    
    mutating func pop() -> T? {
        let current = top
        top = current?.next
        return current?.value
    }
    
    func peek() -> T? {
        top?.value
    }
    
    func isEmpty() -> Bool {
        top == nil
    }
}

var lnkedStack = LinkedStack<Int>()
lnkedStack.push(1)
lnkedStack.push(2)
lnkedStack.push(3)

lnkedStack.peek()
lnkedStack.pop()
lnkedStack
print(lnkedStack.pop()!)
lnkedStack.isEmpty()
lnkedStack.pop()
lnkedStack.isEmpty()


class Sample {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class A: Sample {
    required init(name: String) {
        super.init(name: name)
    }
    
    convenience init(name: String, age: Int) {
        //
       self.init(name: name)
    }
}

// MARK: - Overroide stored or computed property

class Vehicle {
    var speed = 20
    
    var name: String {
        "Vehicle"
    }
}

class Car: Vehicle {
    override var speed: Int {
        get { super.speed }
        set { super.speed = newValue }
    }
    
    override var name: String {
        get { "Car Vehicle" }
    }
}


// MARK: - Retail cycle

class AA {
    var b: B?
    
    deinit {
        print("AA deinit")
    }
}

class B {
    
    weak var aa: AA?
    
    deinit {
        print("B deinit")
    }
}

var aa: AA? = AA()
var b: B? = B()

aa?.b = b
b?.aa = aa

aa = nil
b = nil

// MARK: - Puzzle

// Q. wrtie a function to remove voivels and " " from a given string

func removeVowelsAndSpace(from string: String) -> String {
    let charsToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
    var outputString = ""

    for char in string {
        if charsToRemove.contains(char.lowercased()) {
            continue
        }
        outputString.append(char)
    }
    return outputString
}

print(removeVowelsAndSpace(from: "I Love my India. We can go to there"))


//: [Next](@next)
