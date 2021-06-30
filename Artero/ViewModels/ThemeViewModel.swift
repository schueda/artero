//
//  ThemeViewModel.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class ThemeViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    
    @Published var currentDayActivity: Activity?
    
    let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
        cancellable = repository.get(date: Date())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("ThemeViewModel completion: \(completion)")
            }, receiveValue: { [weak self] value in
                self?.currentDayActivity = value
            })
        _ = repository.getAll(order: .orderedDescending)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func saveActivity(activity: Activity) {
        repository.save(activity)
    }
}
