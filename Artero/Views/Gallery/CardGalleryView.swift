//
//  CardGalleryView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct CardGalleryView: View {
    @StateObject var singleActivityViewModel = SingleActivityViewModel(repository: UserDefaultsActivityRepository.shared)
    
    var activity: Activity
    var frameSize: CGFloat
    
    var body: some View {
        NavigationLink(
            destination: SingleActivityView(viewModel: singleActivityViewModel, activity: activity),
            label : {
                if let activity = activity {
                    if let image = activity.image {
                        VStack (alignment:.leading) {
                            
                            Spacer()
                            HStack {
                                
                                Text(activity.theme?.name ?? "")
                                    .textCase(.uppercase)
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            HStack {
                                
                                Text(DateUtils.formatToLong(date: activity.date, languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                                    .font(.system(size: 18, weight: .regular, design: .default))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
                        
                        .background(
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
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
                }
            }
        )
    }
}
