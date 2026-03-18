//: [Previous](@previous)

import Foundation
import SwiftUI
import PlaygroundSupport

// MARK: - Macros

// MARK: - @Entry

/** @Enrty macro automates the key generation for

 - EnvironmentValues
 - FocusedValues
 - Transaction


struct User: Identifiable {
    let id: UUID = UUID()
    var name: String
}

extension EnvironmentValues {
    @Entry var primaryColor: Color  = .blue
    @Entry var currentUser: User = User(name: "John")
}


struct SampleView: View {
    @Environment(\.currentUser) var currentUser: User
    @Environment(\.primaryColor) var primaryColor: Color
    
    var body: some View {
        Text(currentUser.name)
            .foregroundStyle(primaryColor)
    }
}
*/

//: [Next](@next)
