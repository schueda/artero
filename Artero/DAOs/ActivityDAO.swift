//
//  Activity2DAO.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol ActivityDAOProtocol {
    func get(date: Date) -> Activity2?
    func get(date: String) -> Activity2?
    func save(_ activity: Activity2)
    func delete(_ activity: Activity2)
    func delete(date: Date)
    func delete(date: String)
}

class ActivityDAO: ActivityDAOProtocol {
    
    func get(date: Date) -> Activity2? {
        do {
            print("date: \(self.setKey(date: date))")
            guard let data = UserDefaults.standard.data(forKey: self.setKey(date: date)) else {
                return nil
            }
            let activity = try JSONDecoder().decode(Activity2.self, from: data)
            return activity
        } catch {
            return nil
        }
    }
    
    func get(date: String) -> Activity2? {
        do {
            guard let data = UserDefaults.standard.data(forKey: self.setKey(date: date)) else {
                return nil
            }
            let activity = try JSONDecoder().decode(Activity2.self, from: data)
            return activity
        } catch {
            return nil
        }
    }
    
    func save(_ activity: Activity2) {
        do {
            let data = try JSONEncoder().encode(activity)
            print("saving activity")
            print("date: \(self.setKey(date: activity.date))")
            
            UserDefaults.standard.setValue(data, forKey: self.setKey(date: activity.date))
        } catch {
            print("Error saving activity \(error)")
        }
    }
    
    func delete(_ activity: Activity2) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: activity.date))
    }
    
    func delete(date: Date) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: date))
    }
    
    func delete(date: String) {
        UserDefaults.standard.removeObject(forKey: self.setKey(date: date))
    }
    
    
    private func setKey(date: String) -> String {
        return "activity-\(date)"
    }
    
    private func setKey(date: Date) -> String {
        let dateStr = DateUtils.dateToString(date: date, format: "yyyy-MM-dd")
        return "activity-\(dateStr)"
    }
}
