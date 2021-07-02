//
//  Onboarding3View.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct Onboarding3View: View {
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
