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
    var allActivitiesSubject: CurrentValueSubject<[Activity], Error> { get set }
    func save(_ activity: Activity)
    func delete(_ activity: Activity)
    func getAll(order: ComparisonResult) -> AnyPublisher<[Activity], Error>
    func get(date: Date) -> AnyPublisher<Activity?, Error>
}

class UserDefaultsActivityRepository: ActivityRepository {
    var allActivitiesSubject = CurrentValueSubject<[Activity], Error>([])
    private let prefix = "activity-"
    static let shared = UserDefaultsActivityRepository()
    
    fileprivate init() {}
    
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
    
    fileprivate func fetch(key: String) -> Activity? {
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
    
    func get(date: Date) -> AnyPublisher<Activity?, Error> {
        getAll()
            .tryMap { activities in
                activities.first { self.dateToKey($0.date) == self.dateToKey(date) }
            }
            .eraseToAnyPublisher()
    }
    
    func get(date: String) -> AnyPublisher<Activity?, Error> {
        getAll()
            .tryMap { activities in
                activities.first { self.dateToKey($0.date) == self.dateToKey(date) }
            }
            .eraseToAnyPublisher()
    }
    
    func getAll(order: ComparisonResult = .orderedDescending) -> AnyPublisher<[Activity], Error> {
        refreshSubject(order: order)
        let activities = fetchActivities(order: order)
        return Just(activities)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    fileprivate func fetchActivities(order: ComparisonResult = .orderedDescending) -> [Activity] {
        var activities: [Activity] = []
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.hasPrefix(self.prefix) {
                if let activity = self.fetch(key: key) {
                    activities.append(activity)
                }
            }
        }
        activities.sort(by: { $0.date.compare($1.date) == (order) })
        return activities
    }
    
    fileprivate func refreshSubject(order: ComparisonResult = .orderedDescending) {
        let activities = fetchActivities(order: order)
        allActivitiesSubject.send(activities)
    }
    
    func save(_ activity: Activity) {
        do {
            let key = self.dateToKey(activity.date)
            if let image = activity.image,
               let imageData = image.pngData(){
                self.saveImage(image: imageData, forKey: key)
            }
            
            activity.image = nil
            let data = try JSONEncoder().encode(activity)
            
            UserDefaults.standard.setValue(data, forKey: key)
            self.refreshSubject()
        } catch {
            print("Error saving activity \(error)")
        }
    }
    
    func delete(_ activity: Activity) {
        UserDefaults.standard.removeObject(forKey: self.dateToKey(activity.date))
        self.refreshSubject()
    }
    
    func delete(date: Date) {
        UserDefaults.standard.removeObject(forKey: self.dateToKey(date))
        self.refreshSubject()
    }
    
    fileprivate func dateToKey(_ date: String) -> String {
        return "\(self.prefix)\(date)"
    }
    
    fileprivate func dateToKey(_ date: Date) -> String {
        let dateStr = DateUtils.dateToString(date: date)
        return "\(self.prefix)\(dateStr)"
    }
}
