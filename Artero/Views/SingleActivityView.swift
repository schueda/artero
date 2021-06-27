//
//  SingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 26/06/21.
//

import SwiftUI

struct SingleActivityView: View {
    let activity: Activity?
    @State var isDeleted = false
    
    var body: some View {
        if !isDeleted {
            ScrollView {
                if let activity = activity {
                    SingleActivityHeaderView(activity: activity)
                    if let theme = activity.theme {
                        ThemeTextView(theme: theme)
                    }
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: {
                        self.isDeleted = true
                    }, label: {
                        Image(uiImage: UIImage(systemName: "trash")!)
                    })
                }
            }
            .ignoresSafeArea()
        } else {
            GalleryView()
        }
    }
}

struct SingleActivityHeaderView: View {
    let activity: Activity
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            
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
