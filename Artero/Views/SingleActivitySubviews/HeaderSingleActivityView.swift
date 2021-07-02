//
//  HeaderSingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct HeaderSingleActivityView: View {
    let activity: Activity
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            
            NavigationLink(destination: ImageView(image: activity.image ?? UIImage(systemName: "xmark.app.fill")!)) {
                Image(uiImage: activity.image ?? UIImage(systemName: "xmark.app.fill")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                            )
                )
            }
            
            VStack(alignment: .leading) {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("theme_was", comment: ""))
                            .textCase(.uppercase)
                            .font(.system(size: 12, weight: .bold, design: .default))
                        Text(activity.theme?.name ?? "")
                            .font(.system(size: 28, weight: .bold, design: .default))
                    }
                    .padding(.bottom, 12)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
}
