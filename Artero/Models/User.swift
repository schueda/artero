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

class User: UserDAO, UserProtocol, Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case id, onboardingComplete
    }
    
    static var key = "artero-user-data"
    var id: UUID = UUID()
    @Published var onboardingComplete = false
    
    init(onboardingComplete: Bool = false) {
        super.init()
        self.onboardingComplete = onboardingComplete
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        onboardingComplete = try container.decode(Bool.self, forKey: .onboardingComplete)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(onboardingComplete, forKey: .onboardingComplete)
    }
    
    func save() {
        super.save(self)
    }
}
