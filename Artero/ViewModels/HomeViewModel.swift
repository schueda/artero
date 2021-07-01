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
    var theme: Theme?
    
    let activityRepository: ActivityRepository
    let streakRepository: StreakRepository
    let themeIndexRepository: ThemeIndexRepository
    
    init(activityRepository: ActivityRepository, streakRepository: StreakRepository, themeIndexRepository: ThemeIndexRepository) {
        self.activityRepository = activityRepository
        self.streakRepository = streakRepository
        self.themeIndexRepository = themeIndexRepository
        
        self.theme = self.getTheme()
        
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
        
        streakCancellable = streakRepository.streakSubject
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
    
    func getTheme() -> Theme? {
        let index = themeIndexRepository.getIndex()
        let theme = Theme.themes.first(where: { $0.index == index })
        return theme
    }
}
