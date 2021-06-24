//
//  ActivityRepository2.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 24/06/21.
//

import Foundation

class ActivityRepository2 {
    
    func getTodayActivity() -> Activity2? {
        return Activity2().get(date: Date())
    }
}
