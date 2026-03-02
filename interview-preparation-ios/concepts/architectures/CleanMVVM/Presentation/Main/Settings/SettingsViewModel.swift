//
//  SettingsViewModel.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import Foundation
import Combine
import SwiftUI

@Observable
final class SettingsViewModel: ViewModel {
    
    private let logoutUseCase: LogoutUseCase
    private let notifocationsUseCase: NotificationsUseCase
    private let analytics: AnalyticsTracking
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    var isPushNotificationsOn: Bool = true
    var isEmailNotificationOn: Bool = false
    var isMobileNotificationOn: Bool = true
    var bgColor: Color = .blue
    var date: Date = Date()
    var dates: Set<DateComponents> = []
    
    var isPushNotificationEnabled: Bool = false
    var isEmailNotificationEnabled: Bool = false
    var isSMSNotificationEnabled: Bool = false
    
    init(logoutUseCase: LogoutUseCase,
         notifocationsUseCase: NotificationsUseCase,
         analytics: AnalyticsTracking) {
        self.logoutUseCase = logoutUseCase
        self.notifocationsUseCase = notifocationsUseCase
        self.analytics = analytics
    }
    
    func trackScreenView() {
        analytics.track(.viewedSettingsScreen)
    }
    
    func updateNotifications() async {
        isLoading = true
        defer { isLoading = false }
        do {
            _ = try await notifocationsUseCase.execute()
        } catch {
            
        }
    }
    
    func logout() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            return try await logoutUseCase.execute()
        } catch let error as URLError where [.userAuthenticationRequired].contains(error.code) {
            return false
        } catch {
            self.errorMessage = error.localizedDescription
        }
        return false
    }
}
