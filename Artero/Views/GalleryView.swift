//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    @State var appearingCardIndex = 0
    
    var activities: [Activity] = []
    
    init() {
        self.activities = ActivityController().getAll()
    }
    
    var body: some View {
            TabView(selection: self.$appearingCardIndex) {
                if activities.count > 0 {
                    ForEach(Array(activities.enumerated()), id: \.offset) { index, activity in
                        GalleryCardView(activity: activity, frameSize: self.appearingCardIndex == index ? UIScreen.main.bounds.height * 0.65 : UIScreen.main.bounds.height * 0.5)
                            .tag(activity.id)
                    }
                    .animation(.easeOut)
                } else {
                    PlaceholderView()
                        .tag(UUID())
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarTitle(NSLocalizedString("your_gallery", comment: ""))
            .background(Color("background").edgesIgnoringSafeArea(.bottom))
    }
}

struct GalleryCardView: View {
    var activity: Activity
    var frameSize: CGFloat
    
    var body: some View {
        NavigationLink(
            destination: SingleActivityView(activity: activity),
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

struct PlaceholderView: View {
    var languageCode = Locale.current.languageCode == "pt" ? "pt" : "en"
    
    var body: some View {
            Image(uiImage: UIImage(named: "GalleryPlaceholder\(languageCode)")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height * 0.65)
                .cornerRadius(12.0)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
