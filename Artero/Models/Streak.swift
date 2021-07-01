//
//  Streak.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 29/06/21.
//

import Foundation

class Streak: Codable {
    enum CodingKeys: CodingKey {
        case lastActivityDate, current, best
    }
    
    static let key = "artero-streak"
    var lastActivityDate: Date
    var current: Int
    var best: Int
    
    internal init(lastActivityDate: Date, current: Int, best: Int) {
        self.lastActivityDate = lastActivityDate
        self.current = current
        self.best = best
    }
    
    func increaseCurrent() {
        self.current += 1
    }
    
    func increaseBest() {
        self.best += 1
    }
    
    func addedActivity() {
        if self.isLastActivityToday() {
            return
        }
        
        self.increaseCurrent()
        if (self.current >= self.best) {
            self.best = self.current
        }
    }
    
    func updateTodayStreak() {
        if self.isLastActivityYesterday() || self.isLastActivityToday() {
            return
        }
        
        self.current = 0
    }
    
    private func isLastActivityToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self.lastActivityDate)
    }
    
    private func isLastActivityYesterday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self.lastActivityDate)
    }
}
