//
//  Onboarding2View.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct Onboarding2View: View {
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
