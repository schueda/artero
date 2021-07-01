//
//  NotificationPreference.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation
import UserNotifications

protocol NotificationPreferenceProtocol {
    func save()
}

class NotificationPreference: NotificationPreferenceDAO, Codable, ObservableObject, Equatable {
    enum CodingKeys: CodingKey {
        case active, time
    }
    
    static var key = "notificationPreferences"
    @Published var active: Bool = false;
    @Published var time: Date = Date();
    
    override init() {
        super.init()
        if let notification = super.get(){
            self.active = notification.active
            self.time = notification.time
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        active = try container.decode(Bool.self, forKey: .active)
        time = try container.decode(Date.self, forKey: .time)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(active, forKey: .active)
        try container.encode(time, forKey: .time)
    }
    
    func save() {
        super.save(self)
        self.addNotifications()
    }
    
    static func == (lhs: NotificationPreference, rhs: NotificationPreference) -> Bool {
        return lhs.active == rhs.active && lhs.time == rhs.time
    }
    
    private func addNotifications() {
        if (!self.active) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            return;
        }
        let calendar = Calendar.current
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = NSLocalizedString("notification_title", comment: "")
        notificationContent.body = NSLocalizedString("notification_body", comment: "")
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        
        var datComp = DateComponents()
        datComp.hour = calendar.component(.hour, from: self.time)
        datComp.minute = calendar.component(.minute, from: self.time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}
