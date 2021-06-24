//
//  ThemeRepository.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol ThemeRepositoryProtocol {
    func get(date: Date) -> Theme?
    func get(date: String) -> Theme?
    func getToday() -> Theme?
}

class ThemeRepository: ThemeRepositoryProtocol {
    func get(date: Date) -> Theme? {
        return Theme.themes.first(where: { DateUtils.dateToString(date: $0.date, format: "y-m-d") == DateUtils.dateToString(date: date, format: "y-m-d") })
    }
    
    func get(date: String) -> Theme? {
        return Theme.themes.first(where: { DateUtils.dateToString(date: $0.date, format: "y-m-d") == date })
    }
    
    func getToday() -> Theme? {
        return self.get(date: Date())
    }
}
