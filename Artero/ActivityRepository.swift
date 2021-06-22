//
//  ActivityRepository.swift
//  Artero
//
//  Created by André Schueda on 22/06/21.
//

import UIKit
import SwiftUI

protocol ActivityRepository {
    func save(activity: Activity)
    func delete(activity: Activity)
    func getActivities() -> [Activity]
}


class UsersDefaultActivityRepository: ActivityRepository {
    let photoRepository: PhotoRepository = PhotoDocumentRepository()
    static var identifiersKey: String = "activityKeys"
    
    var keys: [String] {
        UserDefaults.standard.array(forKey: Self.identifiersKey) as? [String] ?? []
    }
    
    func save(activity: Activity) {
        do {
            let data = try JSONEncoder().encode(activity)
            UserDefaults.standard.setValue(data, forKey: activity.formattedDate)
            photoRepository.save(image: activity.image!, withIdentifier: activity.formattedDate + "-image")
            addKey(key: activity.id.uuidString)
        } catch {
            print("Error saving activity \(error)")
        }
        
    }
    
    func delete(activity: Activity) {
        UserDefaults.standard.removeObject(forKey: activity.id.uuidString)
        photoRepository.deleteImage(withIdentifier: activity.id.uuidString + "-image")
        deleteKey(key: activity.id.uuidString)
    }
    
    func getActivities() -> [Activity] {
        var activities: [Activity] = []
        
        do {
            for key in keys {
                let data = UserDefaults.standard.data(forKey: key)
                let activity = try JSONDecoder().decode(Activity.self, from: data!)
                activity.image = photoRepository.getImage(identifier: key + "-image")
                activities.append(activity)
            }
        } catch {
            print("Error getting all activities \(error)")
        }
        return activities
    }
    
    fileprivate func addKey(key: String) {
        var keys = self.keys
        keys.append(key)
        UserDefaults.standard.setValue(keys, forKey: Self.identifiersKey)
        
    }
    
    fileprivate func deleteKey(key: String) {
        var keys = self.keys
        keys.removeAll { $0 == key }
    }
    
}
