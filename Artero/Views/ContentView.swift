//
//  ContentView.swift
//  app das frutas
//
//  Created by André Schueda on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var user: User = UserController().get()
    
    var body: some View {
        if user.onboardingComplete {
            NavigationView {
                ScrollView {
                    VStack {
                        HomeView(viewModel: HomeViewModel(repository: UserDefaultsActivityRepository.shared))
                    }
                }
                .background(Color("background").edgesIgnoringSafeArea(.bottom))
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
