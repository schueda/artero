//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct ThemeView: View {
    
    var activityRepository: ActivityRepository = UsersDefaultActivityRepository()
    
    @State private var selectedImage: UIImage?
    
    var tema: String
    
    var body: some View {
        ScrollView {
            NavigationLink(
                destination: ImagePickerView(selectedImage: $selectedImage, sourceType: .photoLibrary),
                label : {
                    Text("gallery!")
                        .padding()
                })
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                Button("save") {
                    activityRepository.save(activity: Activity(date: Date(), theme: "Religião", text: "lararararara alksdjlaksjd alskjdlaksjd alskdjalskdj", image: selectedImage))
                }
            }
        }
    }
}
