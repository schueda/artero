//
//  User.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 25/06/21.
//

import Foundation

protocol UserProtocol {
    func save()
}

class User: UserDAO, UserProtocol, Codable {
    static var key = "artero-user-data"
    var id: UUID = UUID()
    var onboardingComplete = false
    
    func save() {
        super.save(self)
    }
}
