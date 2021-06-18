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
            VStack {
                
                if savedImage != nil {
                    Image(uiImage: savedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                    
                    Button("delete") {
                        photoRepository.deleteImage(withIdentifier: "background")
                        savedImage = nil
                    }
                }
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                    
                    Button("save") {
                        photoRepository.save(image: selectedImage!, withIdentifier: "background")
                        savedImage = selectedImage
                    }
                } else {
                    Image(systemName: "snow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                }
                
                Button("Camera") {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }.padding()
                
                Button("photo") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()
                
            }
            
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.$sourceType)
            }
            
            .navigationBarTitle("Demo")
            .onAppear {
                savedImage = photoRepository.getImage(identifier: "background")
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
