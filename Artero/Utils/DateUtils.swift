//
//  DateUtils.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

struct DateUtils {
    static func dateToString(date: Date, format: String? = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func stringToDate(date: String, format: String? = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
    
    static func formatToLong(date: Date, languageCode: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: languageCode)
        return dateFormatter.string(from: date)
    }
}
