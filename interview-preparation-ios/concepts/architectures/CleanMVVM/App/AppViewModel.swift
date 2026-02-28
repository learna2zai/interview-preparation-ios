//
//  AppViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine

@Observable
final class AppSession {
    
    var isAuthenticated: Bool = false
    
    func logout() {
        isAuthenticated = false
    }
}

@Observable
final class AppViewModel: ViewModel {
    var isLoading: Bool = true
    var errorMessage: String? = nil

    var currentRoute: AppRoute = .login
    var session: AppSession
    private let tokenStore: TokenStoring
    
    init(session: AppSession,
         tokenStore: TokenStoring) {
        self.session = session
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
                session.isAuthenticated = true
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
