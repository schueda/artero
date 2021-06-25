//
//  Activity2DAO.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation
import UIKit

protocol ActivityDAOProtocol {
    func get(key: String) -> Activity?
    func get(date: Date) -> Activity?
    func get(date: String) -> Activity?
    func getAll(order: ComparisonResult?) -> [Activity]
    func save(_ activity: Activity)
    func delete(_ activity: Activity)
    func delete(date: Date)
    func delete(date: String)
}

class ActivityDAO: ActivityDAOProtocol {
    private let prefix = "activity-"
    
    private func getImagePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    private func saveImage(image: Data, forKey key: String) {
        do  {
            guard let imagePath = self.getImagePath(forKey: key) else { return }
            try image.write(to: imagePath, options: .atomic)
        } catch let err {
            print("Saving image resulted in error: ", err)
        }
    }
    
    private func getImage(forKey key: String) -> Data? {
        if let imagePath = self.getImagePath(forKey: key),
           let imageData = FileManager.default.contents(atPath: imagePath.path) {
            return imageData
        }
        
        return nil
    }
    
    func get(key: String) -> Activity? {
        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            let activity = try JSONDecoder().decode(Activity.self, from: data)
            activity.image = self.getImage(forKey: key)
            
            return activity
        } catch {
            return nil
        }
    }
    
    func get(date: Date) -> Activity? {
        return self.get(key: self.setKey(date: date))
        
    }
    
    func get(date: String) -> Activity? {
        return self.get(key: self.setKey(date: date))
        
    }
    
    func getAll(order: ComparisonResult? = .orderedDescending) -> [Activity] {
        var activities: [Activity] = []
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.hasPrefix(self.prefix) {
                if let activity = self.get(key: key) {
                    activities.append(activity)
                }
            }
        }
        return activities.sorted(by: { $0.date.compare($1.date) == (order ?? .orderedDescending) })
    }
    
    func save(_ activity: Activity) {
        do {
            let key = self.setKey(date: activity.date)
            if let image = activity.image {
                self.saveImage(image: image, forKey: key)
            }
            
            activity.image = nil
            let data = try JSONEncoder().encode(activity)
            
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print("Error saving activity \(error)")
        }
    }
    
    func delete(_ activity: Activity) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: activity.date))
    }
    
    func delete(date: Date) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: date))
    }
    
    func delete(date: String) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: date))
    }
    
    
    private func setKey(date: String) -> String {
        return "\(self.prefix)\(date)"
    }
    
    private func setKey(date: Date) -> String {
        let dateStr = DateUtils.dateToString(date: date)
        return "\(self.prefix)\(dateStr)"
    }
}
