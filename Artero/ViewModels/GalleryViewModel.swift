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
                print("completion: \(completion)")
            } receiveValue: { [weak self] value in
                print(value)
                self?.activities = value
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
