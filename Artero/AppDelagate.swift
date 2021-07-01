//
//  AppDelagate.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation

import Combine
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var cancellable: AnyCancellable?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        cancellable = UserDefaultsStreakRepository.shared.get()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { value in
                if let value = value {
                    value.updateTodayStreak()
                    UserDefaultsStreakRepository.shared.save(value)
                    self.cancellable?.cancel()
                }
            }
        return true
    }
}
