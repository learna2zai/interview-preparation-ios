//: [Previous](@previous)

import Foundation

// MARK: - Generics


struct Stack<Element> {
    
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        items.popLast()
    }
}

extension Stack {
    var topItem: Element? {
        return items.last
    }
}

func findIndex<T: Equatable>(of valueToFind: T, in items: [T]) -> Int? {
    
    for (index, value) in items.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// MARK: - Associated Type

protocol Container {
    associatedtype Item: Equatable
    mutating func push(_ item: Item)
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}


struct GStack<Element>: Container where Element: Equatable {
    
    var items: [Element] = []
    
    var count: Int {
        items.count
    }
    
    subscript(i: Int) -> Element {
        if i >= items.count || i < 0 {
            fatalError("Index out of range")
        }
        return items[i]
    }
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        items.popLast()
    }
    
    func makeIterator() -> IndexingIterator<[Element]> {
        items.makeIterator()
    }
}

//extension GStack: Sequence {
//    
//    func makeIterator() -> IndexingIterator<[Element]> {
//        items.makeIterator()
//    }
//}

var stack = GStack<String>()
stack.push("Hello")
stack.push("World")


//: [Next](@next)
