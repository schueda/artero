//
//  FeedBackThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct FeedbackThemeView: View {
    @Binding var isGalleryShowing: Bool
    @Binding var isFeedbackShowing: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80, weight: .regular, design: .default))
            Text(NSLocalizedString("activity_saved_on", comment: ""))
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding(.top, 5)
                .padding(.bottom, -3)
            Text(NSLocalizedString("gallery", comment: ""))
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(Color(UIColor.link))
                .onTapGesture {
                    isGalleryShowing = true
                    isFeedbackShowing = false
                }
        }
        .frame(width: 230, height: 230)
        .background(Color(UIColor.systemGray6).opacity(0.9))
        .cornerRadius(14)
        .zIndex(1)
    }
}

