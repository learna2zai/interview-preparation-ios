//
//  NotificationRepository.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol NotificationRepository {
    func getNotifications() async throws -> Notifications
    func updateNotifications(notications: Notifications) async throws
}
