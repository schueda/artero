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
            ScrollView {
                NavigationLink(
                    destination: ThemeView(tema: "Amarelo"),
                    label : {
                        Text("botao pro tema diario")
                            .padding()
                    })
                
                NavigationLink(
                    destination: ActivityView(),
                    label : {
                        Text("botao pra tela de atividade")
                            .padding()
                    })
                
                NavigationLink(
                    destination: GalleryView(photo: "diatal"),
                    label : {
                        Text("botao pra galeria")
                            .padding()
                    })
                
                Button("Salvar uma activity aleatoria") {
                    let activity = Activity(date: Date(), theme: "Mar", text: "lululu", image: UIImage(systemName: "pencil"))
                    activityRepository.save(activity: activity)
                    for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                        print("\(key) = \(value) \n")
                    }
                }
            }
            .navigationBarTitle("Demo")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
