//
//  Activity2.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation
import UIKit

class Activity: Codable {
    enum CodingKeys: CodingKey {
        case id, theme, date
    }
    
    var id = UUID()
    var theme: Theme?
    var date: Date = Date()
    var image: UIImage?
    
    internal init(theme: Theme, date: Date, image: UIImage) {
        self.theme = theme
        self.date = date
        self.image = image
    }
}
