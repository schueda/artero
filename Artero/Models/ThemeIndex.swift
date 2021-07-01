//
//  ThemeIndex.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation

class ThemeIndex: Codable {
    let index: Int
    let lastChange: Date
    
    init(_ index: Int) {
        self.index = index
        lastChange = Date()
    }
}
