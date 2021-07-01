//
//  ActivityViewModel.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 30/06/21.
//

import Foundation
import Combine

class ActivityViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    @Published var streak: Streak?
    let repository: StreakRepository
    
    init(repository: StreakRepository) {
        self.repository = repository
        cancellable = repository.streakSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                print("streak completion: \(completion)")
            } receiveValue: { [weak self] value in
                self?.streak = value
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
