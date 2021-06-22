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
                NavigationLink(
                    destination: ThemeView(tema: "Amarelo"),
                    label : {
                        
                        ZStack {
                            
                            Image("art05")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 370, height: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(12.0)
                                .padding(4)
                            
                            VStack (alignment: .leading) {
                            
                                HStack  {
                                    
                                    VStack (alignment: .leading) {
                                        
                                        Text("TEMA DO DIA")
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                        
                                        Text("Amarelo")
                                            .font(.system(size: 28, weight: .bold, design: .default))
                                            .foregroundColor(.white)
                                                                        
                                    }
                                    
                                   // Spacer()
                                 
                                    Image(systemName:"chevron.right")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    
                                }
                            
                            Text("15 de junho")
                                .font(.system(size: 13, weight: .bold, design: .default))
                                .foregroundColor(.white)
                            }
                        }
                        
                    })
                
                NavigationLink(
                    destination: ActivityView(),
                    label : {
                        
                        ZStack {
                            
                            Rectangle()
                                .frame(width: 370, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(12.0)
                                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .padding(4)
                            
                            VStack (alignment: .leading) {
                            
                                HStack  {
                                    
                                    Image(systemName:"sparkles")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.yellow)
                                    
                                    VStack (alignment: .leading) {
                                        
                                      
                                        Text("ATIVIDADE")
                                            .font(.system(size: 17, weight: .semibold, design: .default))
                                            .foregroundColor(.gray)
                                        
                                        Text("Sem sequência")
                                            .font(.system(size: 28, weight: .bold, design: .default))
                                            .foregroundColor(.black)
                                                                        
                                    }
                                    
                                   // Spacer()
                                 
                                    Image(systemName:"chevron.right")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    
                                }
                          
                            }
                        }
                        
                            
                    })
                
                NavigationLink(
                    destination: GalleryView(foto: "diatal"),
                    label : {
                        
                        ZStack {
                            
                            Rectangle()
                           .frame(width: 370, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                           .cornerRadius(12.0)
                           .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                               .padding(4)
                            
                            HStack {
                            
                            }
                            
                            Image(systemName:"chevron.right")
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                          
                    })
                
            }
           // .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          //  .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .navigationBarTitle("Bom dia!")
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
