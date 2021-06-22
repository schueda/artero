//
//  GalleryView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct GalleryView: View {
    let repository: ActivityRepository = UsersDefaultActivityRepository()
    var photo: String
    
    var body: some View {
        ScrollView {
            ForEach(repository.getActivities(), id: \.id) { activity in
                Text(activity.theme)
                Image(uiImage: activity.image ?? UIImage(systemName: "hare")!)
                    
            }
        }
    }
}

