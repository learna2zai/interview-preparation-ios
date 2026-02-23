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
    
    var isLoding: Bool = false
    var errorMessage: String? = nil
    
    init(usecase: LogoutUseCase, appViewModel: AppViewModel) {
        self.logoutUseCase = usecase
        self.appVierwModel = appViewModel
    }
    
    var isPushNotificationEnabled: Bool = false
    var isEmailNotificationEnabled: Bool = false
    var isSMSNotificationEnabled: Bool = false
    
    func logout() async {
        isLoding = true
        defer { isLoding = false }
        do {
            let result = try await logoutUseCase.execute()
            self.appVierwModel.setLoggedInStatus(result)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
