//
//  Activity2.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol ActivityProtocol {
    func save()
}

class Activity: ActivityDAO, ActivityProtocol, Codable {
    var id = UUID()
    var theme: Theme?
    var date: Date = Date()
    var image: Data?
    
    override init() { }
    
    internal init(theme: Theme, date: Date, image: Data) {
        self.theme = theme
        self.date = date
        self.image = image
    }
    
    func save() {
        super.save(self)
    }
}
