//
//  SingleActivityViewModel.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class SingleActivityViewModel: ObservableObject {
    let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
    }
    
    
    func delete(_ activity: Activity) {
        repository.delete(activity)
    }
}
