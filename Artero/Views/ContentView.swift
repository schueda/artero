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
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack {
                    HomeView()
                    
                }
                
            }
            
            .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.bottom))
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
