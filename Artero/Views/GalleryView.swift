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
        GeometryReader { geometry in
            TabView(selection: self.$appearingCardIndex) {
                ForEach(Array(activities.enumerated()), id: \.offset) { index, activity in
                    GalleryCardView(activity: activity, frameSize: self.appearingCardIndex == index ? geometry.size.height - geometry.size.height/5 : geometry.size.height - geometry.size.height/3)
                        .tag(activity.id)
                }
                .animation(.easeOut)
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarTitle("Sua Galeria")
        }
    }
}

struct GalleryCardView: View {
    var activity: Activity
    var frameSize: CGFloat
    
    var body: some View {
        NavigationLink(
            destination: ThemeView(),
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
                                
                                Text(DateUtils.formatToLong(date: activity.date, languageCode: Locale.current.languageCode == "pt_BR" ? "pt_BR" : "en_US"))
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

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
