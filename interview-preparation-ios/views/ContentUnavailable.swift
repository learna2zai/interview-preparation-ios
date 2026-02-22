//
//  ContentUnavailable.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 22/02/26.
//

import SwiftUI

struct ContentUnavailable: View {
    var body: some View {
        ContentUnavailableView("Not implemented",
                               systemImage: "newspaper.fill",
                               description: Text("Will be added in future"))
    }
}

#Preview {
    ContentUnavailable()
}
