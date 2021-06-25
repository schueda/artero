//
//  ActivityRepository2.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 24/06/21.
//

import Foundation

protocol ActivityControllerProtocol {
    func getTodayActivity() -> Activity?
    func getAll() -> [Activity]
}

class ActivityController {
    
    func getTodayActivity() -> Activity? {
        return Activity().get(date: Date())
    }
    
    func getAll() -> [Activity] {
        return Activity().getAll()
    }
}
