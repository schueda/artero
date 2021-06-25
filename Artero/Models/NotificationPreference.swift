//
//  NotificationPreference.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol NotificationPreferenceProtocol {
    func save()
}

class NotificationPreference: NotificationPreferenceDAO, Codable {
    static var key = "notificationPreferences"
    var active: Bool = false;
    var time: Date?;
    
    override init() {
        super.init()
        if let notification = super.get(){
            self.active = notification.active
            self.time = notification.time ?? nil
        }
    }
    
    func save() {
        super.save(self)
    }
}
