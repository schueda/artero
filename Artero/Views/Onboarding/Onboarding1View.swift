//
//  Onboarding1View.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct Onboarding1View: View {
    var body: some View {
        ZStack {
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
