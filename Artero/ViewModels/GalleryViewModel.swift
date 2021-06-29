//
//  GalleryViewModel.swift
//  Artero
//
//  Created by André Schueda on 29/06/21.
//

import Combine
import Foundation

class GalleryViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    @Published var activities: [Activity] = []
    
    init() {
        cancellable = UserDefaultsActivityRepository.shared.allActivitiesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion: \(completion)")
            } receiveValue: { [weak self] value in
                self?.activities = value
            }
        _ = UserDefaultsActivityRepository.shared.getAllActivities()
    }
    
    deinit {
        cancellable?.cancel()
    }
}
