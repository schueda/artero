//
//  AppDelagate.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var streak: Streak?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = UserDefaultsStreakRepository.shared.get()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] value in
                self?.streak = value
                //to do: ver se tem que arrumar o streak
                //to do: se esse codigo nao rodar colocar o cancellable como variavel global e chamar o cancellable.cancel()
            }


        return true
    }
}
