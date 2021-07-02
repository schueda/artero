//
//  FakeButtonThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct FakeButtonThemeView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Text(NSLocalizedString("art_sent", comment: ""))
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .font(.system(size: 17, weight: .semibold, design: .default))
            .foregroundColor(.white)
            .background(Color(.gray))
            .cornerRadius(10.0)
        })
        .padding(.horizontal)
        .padding(.bottom, UIScreen.main.bounds.height * 0.05)
        .disabled(true)
    }
}
