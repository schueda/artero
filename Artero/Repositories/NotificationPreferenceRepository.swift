//
//  File.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol NotificationPreferenceRepositoryProtocol {
    func get() -> NotificationPreference?
    func save(notificationPreference: NotificationPreference)
}

struct NotificationPreferenceRepository: NotificationPreferenceRepositoryProtocol {
    
    func get() -> NotificationPreference? {
        return NotificationPreference().get() ?? nil
    }
    
    func save(notificationPreference: NotificationPreference) {
        notificationPreference.save(notificationPreference)
    }
}
