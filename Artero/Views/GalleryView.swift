//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var appearingCardIndex = 0
    var spacing: CGFloat = 15
    var activities: [Activity] = []
    
    fileprivate func getMiddle() -> Int {
        activities.count / 2
    }
    
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
        ZStack {
            if let activity = activity {
                if let data = activity.image,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
                }
                VStack {
                    Text(activity.theme?.name ?? "")
                        .fontWeight(.bold)
                    if let date = activity.date {
                        Text(DateUtils.dateToString(date: date))
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: frameSize)
        .cornerRadius(25)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
