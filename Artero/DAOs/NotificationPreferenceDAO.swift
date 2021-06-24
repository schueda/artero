//
//  NotificationPreference.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol NotificationPreferenceDAOProtocol {
    func save(_ notificationPreference: NotificationPreference)
    func get() -> NotificationPreference?;
}

class NotificationPreferenceDAO: NotificationPreferenceDAOProtocol {
    func save(_ notificationPreference: NotificationPreference) {
        do {
            let data = try JSONEncoder().encode(notificationPreference)
            UserDefaults.standard.setValue(data, forKey: NotificationPreference.key)
        } catch {
            print("Error saving notification preference \(error)")
        }
    }
    
    func get() -> NotificationPreference? {
        do {
            guard let data = UserDefaults.standard.data(forKey: NotificationPreference.key) else {
                return nil
            }
            let notificationPreference = try JSONDecoder().decode(NotificationPreference.self, from: data)
            return notificationPreference
        } catch {
            return nil
        }
    }
}
