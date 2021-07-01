//
//  ContentView.swift
//  app das frutas
//
//  Created by André Schueda on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var user: User = UserController().get()
    @StateObject var homeViewModel = HomeViewModel(activityRepository: UserDefaultsActivityRepository.shared, streakRepository: UserDefaultsStreakRepository.shared, themeIndexRepository: UserDefaultsThemeIndexRepository.shared)
    
    var body: some View {
        if user.onboardingComplete {
            NavigationView {
                HomeView(viewModel: homeViewModel)
            }
            .accentColor(Color("text"))
        } else {
            NavigationView {
                OnboardingView().navigationBarHidden(true)
            }
            .accentColor(Color("text"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
