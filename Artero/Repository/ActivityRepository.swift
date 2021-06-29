//
//  ActivityRepository.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Foundation
import Combine
import UIKit

protocol ActivityRepository {
    func getAllActivities() -> AnyPublisher<[Activity], Error>
}

class UserDefaultsActivityRepository: ActivityRepository {
    let allActivitiesSubject = CurrentValueSubject<[Activity], Error>([])
    
    private let prefix = "activity-"
    
    static let shared = UserDefaultsActivityRepository()
    
    fileprivate init() {
        
    }
    
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
            if  let imageData = self.getImage(forKey: key),
                let image = UIImage(data: imageData) {
                activity.image = image
            }
            
            return activity
        } catch {
            return nil
        }
    }
    
    func getAllActivities() -> AnyPublisher<[Activity], Error> {
        var activities: [Activity] = []
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.hasPrefix(self.prefix) {
                if let activity = self.get(key: key) {
                    activities.append(activity)
                }
            }
        }
//        return activities.sorted(by: { $0.date.compare($1.date) == (order ?? .orderedDescending) })
        allActivitiesSubject.send(activities)
        return Just(activities)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
