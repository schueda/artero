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

class NotificationPreference: NotificationPreferenceDAO, Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case active, time
    }
    
    static var key = "notificationPreferences"
    @Published var active: Bool = false;
    @Published var time: Date?;
    
    override init() {
        super.init()
        if let notification = super.get(){
            self.active = notification.active
            self.time = notification.time ?? nil
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
    }
}
