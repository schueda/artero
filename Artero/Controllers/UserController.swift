//
//  UserController.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 25/06/21.
//

import Foundation

protocol UserControllerProtocol {
    func get() -> User
    func save(user: User)
}

struct UserController: UserControllerProtocol {
    
    func get() -> User {
        return User().get()
    }
    
    func save(user: User) {
        user.save(user)
    }
}
