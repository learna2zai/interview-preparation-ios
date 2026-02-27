//
//  SettingsViewModel.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import Foundation
import Combine
import SwiftUI

@Observable
final class SettingsViewModel: ViewModel {
    
    private let logoutUseCase: LogoutUseCase
    private let appVierwModel: AppViewModel
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    var isPushNotificationsOn: Bool = true
    var isEmailNotificationOn: Bool = false
    var isMobileNotificationOn: Bool = true
    var bgColor: Color = .blue
    var date: Date = Date()
    var dates: Set<DateComponents> = []
    
    init(usecase: LogoutUseCase, appViewModel: AppViewModel) {
        self.logoutUseCase = usecase
        self.appVierwModel = appViewModel
    }
    
    var isPushNotificationEnabled: Bool = false
    var isEmailNotificationEnabled: Bool = false
    var isSMSNotificationEnabled: Bool = false
    
    func trackScreenView() {
        //
    }
    
    func logout() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await logoutUseCase.execute()
            self.appVierwModel.setLoggedInStatus(!result)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
