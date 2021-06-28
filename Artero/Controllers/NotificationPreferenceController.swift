//
//  File.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol NotificationPreferenceControllerProtocol {
    func get() -> NotificationPreference
    func save(notificationPreference: NotificationPreference)
}

struct NotificationPreferenceController: NotificationPreferenceControllerProtocol {
    
    func get() -> NotificationPreference {
        return NotificationPreference().get() ?? NotificationPreference()
    }
    
    func save(notificationPreference: NotificationPreference) {
        notificationPreference.save(notificationPreference)
    }
}
