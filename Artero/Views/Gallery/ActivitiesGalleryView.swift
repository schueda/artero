//
//  ActivitiesGalleryView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct ActivitiesGalleryView: View {
    @ObservedObject var viewModel: GalleryViewModel
    let appearingCardIndex: Int
    
    var body: some View {
        ForEach(Array(viewModel.activities.enumerated()), id: \.offset) { index, activity in
            CardGalleryView(activity: activity, frameSize: self.appearingCardIndex == index ? UIScreen.main.bounds.height * 0.65 : UIScreen.main.bounds.height * 0.5)
                .tag(activity.id)
        }
        .animation(.easeOut)
    }
}
