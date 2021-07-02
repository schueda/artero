//
//  ThemeHomeCardView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct ThemeCardHomeView: View {
    @StateObject var themeViewModel = ThemeViewModel(activityRepository: UserDefaultsActivityRepository.shared, streakRepository: UserDefaultsStreakRepository.shared)
    
    @Binding var theme: Theme?
    @Binding var currentDayActivity: Activity?
    
    var body: some View {
        NavigationLink(
            destination: ThemeView(viewModel: themeViewModel, theme: $theme),
            label : {
                VStack (alignment:.leading) {
                    HStack {
                        
                        Text(NSLocalizedString("daily_theme", comment: "")) .textCase(.uppercase)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    Text(NSLocalizedString(theme?.name ?? "", comment: ""))
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        Text(DateUtils.formatToLong(date: Date(), languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                            .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                        if currentDayActivity != nil {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: currentDayActivity != nil ? 170 : 280, maxHeight: currentDayActivity != nil ? 170 : 280, alignment: .leading)
                
                .background(
                    Image(theme?.inspiration.image ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
            }
        )
    }
}

