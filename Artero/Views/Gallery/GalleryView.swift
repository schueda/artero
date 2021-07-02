//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    @State var appearingCardIndex = 0
    @ObservedObject var viewModel: GalleryViewModel
    let placeholderPostfixes = [Locale.current.languageCode == "pt" ? "pt" : "en", "1", "2", "3", "4", "5"]
    
    var body: some View {
            TabView(selection: self.$appearingCardIndex) {
                if !viewModel.activities.isEmpty {
                    ActivitiesGalleryView(viewModel: viewModel, appearingCardIndex: appearingCardIndex)
                } else {
                   PlaceholderGalleryView(placeholderPostfixes: placeholderPostfixes, appearingCardIndex: appearingCardIndex)
                    .animation(.easeOut)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarTitle(NSLocalizedString("your_gallery", comment: ""))
            .background(Color("background").edgesIgnoringSafeArea(.bottom))
            .id(viewModel.activities.isEmpty ? placeholderPostfixes.count : viewModel.activities.count)
    }
}

//struct GalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryView()
//    }
//}
