//
//  StreakRepository.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 29/06/21.
//

import Foundation
import Combine
import UIKit

protocol StreakRepository {
    var streakSubject: CurrentValueSubject<Streak?, Error> { get set }
    func save(_ activity: Streak)
    func get() -> AnyPublisher<Streak?, Error>
}

class UserDefaultsStreakRepository: StreakRepository {
    var streakSubject = CurrentValueSubject<Streak?, Error>(nil)
    static let shared = UserDefaultsStreakRepository()
    
    fileprivate init() {}
    
    func save(_ activity: Streak) {
        do {
            let data = try JSONEncoder().encode(activity)
            UserDefaults.standard.setValue(data, forKey: Streak.key)
            self.refreshSubject()
        } catch {
            print("Error saving streak \(error)")
        }
    }
    
    func get() -> AnyPublisher<Streak?, Error> {
        refreshSubject()
        let streak = fetchStreak()
        return Just(streak)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    fileprivate func fetchStreak() -> Streak? {
        do {
            guard let data = UserDefaults.standard.data(forKey: Streak.key) else {
                return nil
            }
            let streak = try JSONDecoder().decode(Streak.self, from: data)
            return streak
        } catch {
            return nil
        }
    }
    
    fileprivate func refreshSubject() {
        let streak = fetchStreak()
        streakSubject.send(streak)
    }
}
