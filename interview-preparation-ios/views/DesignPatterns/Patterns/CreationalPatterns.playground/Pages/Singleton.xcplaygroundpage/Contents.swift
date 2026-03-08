import Foundation

// MARK: - Singleton Pattern

final class SingletonClass: Sendable {
    static let shared = SingletonClass()
    private init() {}
}

// usese case netwk, db conn, cache, config, logger
// its a cdp ensure that a class has only one instance, by providing global access point to this instance.


//: [Previous](@previous) | [Next](@next)
