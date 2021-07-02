//
//  PlaceholderGalleryView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct PlaceholderGalleryView: View {
    let placeholderPostfixes: [String]
    let appearingCardIndex: Int
    
    var body: some View {
        ForEach(Array(placeholderPostfixes.enumerated()), id: \.offset) { index, postFix in
            Image(uiImage: UIImage(named: "GalleryPlaceholder\(postFix)")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: appearingCardIndex == index ? UIScreen.main.bounds.height * 0.65 : UIScreen.main.bounds.height * 0.5)
                .cornerRadius(12.0)
                .tag(index)
        }
    }
}

