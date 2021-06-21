//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    var foto: String
    
    var body: some View {
        ScrollView {
            if PhotoDocumentRepository().getImage(identifier: "background") != nil {
                Image(uiImage: PhotoDocumentRepository().getImage(identifier: "background")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
            }
        }
    }
}
