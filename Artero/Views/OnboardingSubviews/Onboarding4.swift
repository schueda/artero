//
//  Onboarding4.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct Onboarding4View: View {
    @State private var linkActive: Bool = false
    @StateObject private var user: User = UserController().get()
    
    var body: some View {
        ZStack {
            Image("onboarding4")
                .resizable()
                .scaledToFill()
            VStack(){
                VStack(alignment: .leading){
                    Text(NSLocalizedString("OnBoarding4_line1", comment:""))
                    Text(NSLocalizedString("OnBoarding4_line2", comment:""))
                    VStack{
                        Image(NSLocalizedString("OnBoarding4_image1", comment: ""))
                            .padding(.trailing, 30)
                    }
                    Text(NSLocalizedString("OnBoarding4_line3", comment:""))
                    Text(NSLocalizedString("OnBoarding4_line4", comment:""))
                    Text(NSLocalizedString("OnBoarding4_line5", comment:""))
                }
                .padding(.top, 80)
                .padding(.bottom, 110)
                .padding(.trailing, 20)
                .font(.system(size: 32, weight: .heavy, design: .default))
                .foregroundColor(.black)
                
                NavigationLink(
                    destination: HomeView(viewModel: HomeViewModel(activityRepository: UserDefaultsActivityRepository.shared, streakRepository: UserDefaultsStreakRepository.shared, themeIndexRepository: UserDefaultsThemeIndexRepository.shared)),
                    isActive: $linkActive,
                    label : {
                        Text(NSLocalizedString("button_text", comment: ""))
                            .frame(width: 310, height: 54, alignment: .center)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .cornerRadius(10)
                            .shadow(color: Color("shadow"),radius: 5)
                    }
                )
                .onChange(of: linkActive, perform: { value in
                    if (linkActive) {
                        user.onboardingComplete = true
                        user.save()
                    }
                })
            }
        }
    }
}
