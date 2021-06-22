//
//  Activities.swift
//  Artero
//
//  Created by André Schueda on 22/06/21.
//

import UIKit

class Activity: Codable {
    internal init(date: Date, theme: String, text: String, image: UIImage? = nil) {
        self.date = date
        self.theme = theme
        self.text = text
        self.image = image
    }
    
    let id = UUID()
    
    var date: Date
    var theme: String
    var text: String
    
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case theme
        case text
    }
}
