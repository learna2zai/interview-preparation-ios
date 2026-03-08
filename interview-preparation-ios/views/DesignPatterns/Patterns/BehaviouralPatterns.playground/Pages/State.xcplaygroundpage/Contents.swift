//: [Previous](@previous)

import Foundation

// MARK: - State Pattern

// its bdp allows an object alter its behaviour when its internal state changes.

enum SignalState {
    case red
    case orange
    case green
}

class TrafficLight {
    var state: SignalState = .red {
        didSet {
            showLight()
        }
    }
    
    func showLight() {
        print("The light is currently \(state)")
    }
}

let trafficLight = TrafficLight()
trafficLight.state = .orange
trafficLight.state = .green


//: [Next](@next)
