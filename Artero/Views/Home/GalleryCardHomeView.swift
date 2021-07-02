//
//  GalleryHomeCardView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct GalleryCardHomeView: View {
    @Binding var currentDayActivity: Activity?
    @Binding var activities: [Activity]
    
    var galleryImage: UIImage {
        guard let activity = activities.first,
              let image = activity.image else {
            return UIImage(named: "GalleryPlaceholder")!
        }
        return image
    }
    
    @StateObject var galleryViewModel = GalleryViewModel(repository: UserDefaultsActivityRepository.shared)
    
    var body: some View {
        NavigationLink(
            destination: GalleryView(viewModel: galleryViewModel),
            label : {
                VStack (alignment:.trailing) {
                    Image(systemName:"chevron.right")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: currentDayActivity != nil ? 280 : 170 , maxHeight: currentDayActivity != nil ? 280 : 170 , alignment: .topTrailing)
                
                .background(
                    Image(uiImage: galleryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, ]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
            }
        )
    }
}
