import Foundation

// MARK: - Chain of responsibility

// its a bdp that allows passing request along the chain of potential handlers until one of them handles request.

protocol Handler {
    func next() -> Handler?
}

class LoggingHandler: Handler {
    func next() -> Handler? {
        return nil
    }
}

class AuthHandler: Handler {
    func next() -> Handler? {
        nil
    }
}

class RequestHandlerDemo {
    
    let handlers: [Handler] = [LoggingHandler(), AuthHandler()]
    
    func handle() {
        handlers.forEach { handler in
            _ = handler.next()
        }
    }
    
}


//: [Next](@next)
