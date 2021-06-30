//
//  HomeView.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    var allActivitiesCancellable: AnyCancellable?
    var currentDayCancellable: AnyCancellable?
    
    @Published var activities: [Activity] = []
    @Published var currentDayActivity: Activity?
    
    let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
        allActivitiesCancellable = repository.allActivitiesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                print("HomeViewModel completion: \(completion)")
            } receiveValue: { [weak self] value in
                print("HomeViewModel: \(value)")
                self?.activities = value
            }
        currentDayCancellable = repository.get(date: Date())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("HomeViewModel completion: \(completion)")
            }, receiveValue: { [weak self] value in
                print("HomeViewModel: \(value)")
                self?.currentDayActivity = value
            })
        _ = repository.getAll(order: .orderedDescending)
    }
    
    deinit {
        allActivitiesCancellable?.cancel()
        currentDayCancellable?.cancel()
    }
}
