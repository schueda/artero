//
//  OnboardingView.swift
//  Artero
//
//  Created by Bruna Naomi Yamanaka Silva on 25/06/21.
//

import SwiftUI


struct OnboardingView: View {
    @State private var currentTab = 0
    
    var body: some View {
        let yExtension: CGFloat = 50
        GeometryReader { g in
            TabView {
                Onboarding1View()
                Onboarding2View()
                Onboarding3View()
                Onboarding4View()
                
            }
            .frame(width: g.size.width, height: g.size.height + yExtension)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .font(Font.title.bold())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .offset(y: -yExtension)
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .preferredColorScheme(.dark)
    }
}
