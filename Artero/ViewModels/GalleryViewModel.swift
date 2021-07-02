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
    let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
        cancellable = repository.allActivitiesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                print("GalleryViewModel completion: \(completion)")

            } receiveValue: { [weak self] value in
                self?.activities = []
                self?.activities = value
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
