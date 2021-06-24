//
//  ContentView.swift
//  app das frutas
//
//  Created by André Schueda on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var savedImage: UIImage?
    @State private var photoRepository: PhotoRepository = PhotoDocumentRepository()
    @State private var activityRepository: ActivityRepository = UsersDefaultActivityRepository()
    
    var body: some View {
        NavigationView {
            ZStack {
                

                Color(UIColor.systemGray5).edgesIgnoringSafeArea(.bottom)
            
           HomeView()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
