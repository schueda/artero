//
//  ThemeRepository.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol ThemeControllerProtocol {
    func get(date: Date) -> Theme?
    func get(date: String) -> Theme?
    func getToday() -> Theme?
    func getAll(order: ComparisonResult?) -> [Theme]
}

class ThemeController: ThemeControllerProtocol {
    func get(date: Date) -> Theme? {
        return Theme.themes.first(where: { DateUtils.dateToString(date: $0.date) == DateUtils.dateToString(date: date) })
    }
    
    func get(date: String) -> Theme? {
        return Theme.themes.first(where: { DateUtils.dateToString(date: $0.date) == date })
    }
    
    func getToday() -> Theme? {
        return self.get(date: Date())
    }
    
    func getAll(order: ComparisonResult? = .orderedDescending) -> [Theme] {
        return Theme.themes.sorted(by: { $0.date.compare($1.date) == (order ?? .orderedDescending) })
    }
}
