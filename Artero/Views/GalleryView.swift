//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    let repository: PhotoRepository = PhotoDocumentRepository()
    var foto: String
    
    var body: some View {
        ScrollView {
            if repository.getImage(identifier: "background") != nil {
                Image(uiImage: repository.getImage(identifier: "background")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
            }
        }
    }
}
