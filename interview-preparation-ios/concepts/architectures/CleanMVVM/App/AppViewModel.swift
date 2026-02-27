//
//  AppViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine
import SwiftUI

enum AppRoute {
    case register
    case login
    case dashboard
}

@Observable
final class AppViewModel: ViewModel {
    var isLoading: Bool = true
    var errorMessage: String? = nil

    var path = NavigationPath()
    var currentRoute: AppRoute = .login
    private var isLoggIn: Bool = false
    private let tokenStore: TokenStoring
    
    init(tokenStore: TokenStoring) {
        self.tokenStore = tokenStore
    }
    
    func trackScreenView() {
        //
    }
    
    func checkLoggedInStatus() async {
        defer { isLoading = false }
        do {
            if let token = try await tokenStore.getAccessToken(),
                token.isEmpty == false {
                setLoggedInStatus(true)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func setLoggedInStatus(_ status: Bool) {
        isLoggIn = status
        currentRoute = isLoggIn ? .dashboard : .login
    }
}
