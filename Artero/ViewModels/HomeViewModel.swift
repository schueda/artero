//
//  HomeView.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    var streakCancellable: AnyCancellable?
    var allActivitiesCancellable: AnyCancellable?
    var currentDayCancellable: AnyCancellable?
    
    @Published var activities: [Activity] = []
    @Published var currentDayActivity: Activity?
    @Published var streak: Streak?
    
    let activityRepository: ActivityRepository
    let streakRepository: StreakRepository
    
    init(activityRepository: ActivityRepository, streakRepository: StreakRepository) {
        self.activityRepository = activityRepository
        self.streakRepository = streakRepository
        
        allActivitiesCancellable = activityRepository.allActivitiesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                print("HomeViewModel completion: \(completion)")
            } receiveValue: { [weak self] value in
                print("HomeViewModel: \(value)")
                self?.activities = value
            }
        currentDayCancellable = activityRepository.get(date: Date())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("HomeViewModel completion: \(completion)")
            }, receiveValue: { [weak self] value in
                self?.currentDayActivity = value
            })
        _ = activityRepository.getAll(order: .orderedDescending)
        
        streakCancellable = streakRepository.get()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("HomeViewModel completion: \(completion)")
            }, receiveValue: { [weak self] value in
                self?.streak = value
            })
    }
    
    deinit {
        allActivitiesCancellable?.cancel()
        currentDayCancellable?.cancel()
        streakCancellable?.cancel()
    }
}
