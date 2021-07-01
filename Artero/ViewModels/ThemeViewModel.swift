//
//  ThemeViewModel.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class ThemeViewModel: ObservableObject {
    var activityCancellable: AnyCancellable?
    var streakCancellable: AnyCancellable?
    
    @Published var currentDayActivity: Activity?
    @Published var lastStreak: Streak?
    
    let streakRepository: StreakRepository
    let activityRepository: ActivityRepository
    
    init(activityRepository: ActivityRepository, streakRepository: StreakRepository) {
        self.activityRepository = activityRepository
        self.streakRepository = streakRepository
        
        activityCancellable = activityRepository.get(date: Date())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("ThemeViewModel completion: \(completion)")
            }, receiveValue: { [weak self] value in
                self?.currentDayActivity = value
            })
        
        streakCancellable = streakRepository.get()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("ThemeViewModel streak completion: \(completion)")
            }, receiveValue: { [weak self] value in
                self?.lastStreak = value
            })
    }
    
    deinit {
        activityCancellable?.cancel()
        streakCancellable?.cancel()
    }
    
    func save(activity: Activity) {
        activityRepository.save(activity)
        
        if let lastStreak = lastStreak {
            lastStreak.addedActivity()
            streakRepository.save(lastStreak)
        } else {
            let lastStreak = Streak(lastActivityDate: Date(), current: 1, best: 1)
            streakRepository.save(lastStreak)
        }
    }
}
