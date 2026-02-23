//
//  SettingsViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine

@Observable
final class SettingsViewModel {
    
    private let logoutUseCase: LogoutUseCase
    private let appVierwModel: AppViewModel
    
    init(usecase: LogoutUseCase, appViewModel: AppViewModel) {
        self.logoutUseCase = usecase
        self.appVierwModel = appViewModel
    }
    
    var isPushNotificationEnabled: Bool = false
    var isEmailNotificationEnabled: Bool = false
    var isSMSNotificationEnabled: Bool = false
    
    func logout() {
        Task {
            do {
                try await logoutUseCase.execute()
                appVierwModel.setLoggedInStatus(false)
            } catch {
                print("Handle Error \(error.localizedDescription)")
            }
        }
    }
}
