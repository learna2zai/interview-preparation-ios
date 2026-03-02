//
//  NotificationRepositoryImpl.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class NotificationRepositoryImpl: NotificationRepository {
    
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getNotifications() async throws -> Notifications {
        Notifications(pushNotification: true, emailNotification: false, smsNotification: true)
    }
    
    func updateNotifications(notications: Notifications) async throws {
        
    }
}
