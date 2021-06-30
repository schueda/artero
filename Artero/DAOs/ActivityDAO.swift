//
//  Activity2DAO.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation
import UIKit

protocol ActivityDAOProtocol {
    func get(key: String) -> Activity?
    func get(date: Date) -> Activity?
    func get(date: String) -> Activity?
    func getAll(order: ComparisonResult?) -> [Activity]
    func save(_ activity: Activity)
    func delete(_ activity: Activity)
    func delete(date: Date)
    func delete(date: String)
}
