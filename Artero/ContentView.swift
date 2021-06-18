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
    @State private var savedImage: Data?
    
    var body: some View {
        NavigationView {
            VStack {
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                    Button("save") {
                        let image = selectedImage

                        // Convert to Data
                        if let data = image?.pngData() {
                            // Create URL
                            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let url = documents.appendingPathComponent("landscape.png")

                            do {
                                // Write to Disk
                                try data.write(to: url)

                                // Store URL in User Defaults
                                UserDefaults.standard.set(url, forKey: "background")
                                

                            } catch {
                                print("Unable to Write Data to Disk (\(error))")
                            }
                        }
                        savedImage = try? Data(contentsOf: UserDefaults.standard.url(forKey: "background")!)
                        
                    }
                } else {
                    Image(systemName: "snow")
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                }
                
                if savedImage != nil {
                    Image(uiImage: UIImage(data: savedImage!)!)
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
            .navigationBarTitle("Demo")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.$sourceType)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
