//
//  ThemeIndexRepository.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation

protocol ThemeIndexRepository {
    func getIndex() -> Int
}

class UserDefaultsThemeIndexRepository: ThemeIndexRepository {
    static let shared = UserDefaultsThemeIndexRepository()
    fileprivate static let key = "ThemeIndex"
    fileprivate init() {}
    
    fileprivate func save(themeIndex: ThemeIndex) {
        do {
            let data = try JSONEncoder().encode(themeIndex)
            UserDefaults.standard.setValue(data, forKey: Self.key)
        } catch {
            print("Error saving ThemeIndex \(error)")
        }
    }
    
    fileprivate func fetch() -> ThemeIndex {
        do {
            guard let data = UserDefaults.standard.data(forKey: Self.key) else {
                return ThemeIndex(0)
            }
            let themeIndex = try JSONDecoder().decode(ThemeIndex.self, from: data)
            return themeIndex
        } catch {
            return ThemeIndex(0)
        }
    }
    
    func getIndex() -> Int {
        let userDefaultsThemeIndex = self.fetch()
        
        if DateUtils.dateToString(date: userDefaultsThemeIndex.lastChange) == DateUtils.dateToString(date: Date()) {
            return userDefaultsThemeIndex.index
        }
        if userDefaultsThemeIndex.index + 1 >= Theme.themes.count {
            let index = 0
            self.save(themeIndex: ThemeIndex(index))
            return index
        }
        let index = userDefaultsThemeIndex.index + 1
        self.save(themeIndex: ThemeIndex(index))
        return index
    }
}

