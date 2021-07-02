//
//  HeaderThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct HeaderThemeView: View {
    let theme: Theme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            
            NavigationLink(destination: ImageView(image: UIImage(named: theme.inspiration.image)!)) {
                Image(theme.inspiration.image)
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
                        Text(NSLocalizedString("daily_theme", comment: ""))
                            .textCase(.uppercase)
                            .font(.system(size: 12, weight: .bold, design: .default))
                        Text(theme.name)
                            .font(.system(size: 28, weight: .bold, design: .default))
                    }
                    .padding(.bottom, 12)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(theme.inspiration.name) | \(theme.inspiration.year)")
                            .font(.system(size: 13, weight: .bold, design: .default))
                        
                        Text(theme.inspiration.author)
                            .font(.system(size: 13, weight: .regular, design: .default))
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
}
