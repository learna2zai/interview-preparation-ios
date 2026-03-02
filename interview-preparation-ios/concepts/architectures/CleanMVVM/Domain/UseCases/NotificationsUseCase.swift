//
//  NotificationsUseCase.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

final class NotificationsUseCase {
    
    private let notificationRepository: NotificationRepository
    
    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }
    
    func execute() async throws -> Notifications {
        try await notificationRepository.getNotifications()
    }
}
