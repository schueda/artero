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
                            OnBoardingScreen1()
                            OnBoardingScreen2()
                            OnBoardingScreen3()
                            OnBoardingScreen4()
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

struct OnBoardingScreen1: View {
    var body: some View {
        ZStack
        {
                Image("onboarding1")
                    .resizable()
                    .scaledToFill()
            VStack(alignment: .leading){
                Text(NSLocalizedString("OnBoarding1_line1", comment:""))
                Text(NSLocalizedString("OnBoarding1_line2", comment:""))
                Text(NSLocalizedString("OnBoarding1_line3", comment:""))
            }.padding(.bottom, 150)
            .padding(.leading)
            .font(.system(size: 48, weight: .heavy, design: .default))
            .foregroundColor(.black)
        }
        
    }
}
struct OnBoardingScreen2: View {
    var body: some View {
        ZStack {
                    Image("onboarding2")
                        .resizable()
                        .scaledToFill()
                    VStack(alignment: .center){
                        Text(NSLocalizedString("OnBoarding2_line1", comment:""))
                        Text(NSLocalizedString("OnBoarding2_line2", comment:""))
                        Image(NSLocalizedString("OnBoarding2_image1", comment:""))
                            .padding()
                        Text(NSLocalizedString("OnBoarding2_line3", comment:""))
                        Text(NSLocalizedString("OnBoarding2_line4", comment:""))
                        Text(NSLocalizedString("OnBoarding2_line5", comment:""))
                        Image(NSLocalizedString("OnBoarding2_image2", comment:""))
                        
                    }
                    .font(.system(size: 28, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                }
    }
}
struct OnBoardingScreen3: View {
    var body: some View {
        ZStack {
                    Image("onboarding3")
                        .resizable()
                        .scaledToFill()
                    VStack(alignment: .center){
                        Image(NSLocalizedString("OnBoarding3_image1", comment: ""))
                        Image(NSLocalizedString("OnBoarding3_image2", comment: ""))
                        Text(NSLocalizedString("OnBoarding3_line1", comment:""))
                        Text(NSLocalizedString("OnBoarding3_line2", comment:""))
                    }
                    .font(.system(size: 28, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                }
    }
}
struct OnBoardingScreen4: View {
    var body: some View {
        ZStack {
                    Image("onboarding4")
                        .resizable()
                        .scaledToFill()
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
                    .padding(.bottom, 120)
                    .padding(.trailing, 20)
                    .font(.system(size: 32, weight: .heavy, design: .default))
                    .foregroundColor(.black)
                }
    }
}
