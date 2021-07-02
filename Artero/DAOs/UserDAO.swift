//
//  UserDAO.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 25/06/21.
//

import Foundation

protocol UserDAOProtocol {
    func save(_ user: User)
    func get() -> User;
}

class UserDAO: UserDAOProtocol {
    func save(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.setValue(data, forKey: User.key)
        } catch {
            print("Error saving user \(error)")
        }
    }
    
    func get() -> User {
        do {
            guard let data = UserDefaults.standard.data(forKey: User.key) else {
                return User()
            }
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            return User()
        }
    }
}
