//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    
    @State var x: CGFloat = 0 // que bosta de nome de variavel é esse?
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var appearingCardIndex = 0
    var spacing: CGFloat = 15
    
    let repository: ActivityRepository = UsersDefaultActivityRepository()
    var photo: String
    
    var activities: [Activity] = []
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: self.$appearingCardIndex) {
                ForEach(Array(activities.enumerated()), id: \.offset) { index, activity in
                    GalleryCardView(data: activity, frameSize: self.appearingCardIndex == index ? geometry.size.height - geometry.size.height/5 : geometry.size.height - geometry.size.height/3)
                        .tag(activity.id)
                }
                .animation(.easeOut)
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarTitle("Sua Galeria")
        }
    }
    
    fileprivate func getMiddle() -> Int {
        activities.count / 2
    }
    
    init(photo: String) {
        activities = repository.getActivities()
        self.photo = photo
    }
}

struct GalleryCardView: View {
    var data: Activity
    var frameSize: CGFloat
    
    var body: some View {
        ZStack {
            Image(uiImage: (data.image!))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
            
            Text(data.theme)
                .fontWeight(.bold)
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
        .cornerRadius(25)
    }
}
