//
//  HomeView.swift
//  Artero
//
//  Created by Mariana Florencio on 23/06/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView {
            
            VStack (spacing:10) {
                
                CardThemeDay()
                
                CardActivityView()
                
                CardGallery()
                
            }
            
        }
        .padding()
        .navigationBarTitle("Bom dia!")
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            
            HomeView()
        }
    }
}

struct CardActivityView: View {
    var body: some View {
        NavigationLink(
            destination: ActivityView(),
            label : {
                
                
                VStack (alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName:"sparkles")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.yellow)
                        
                        Text("Atividade") .textCase(.uppercase)
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                        
                        //  Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                        
                        
                    }
                    
                    Text("Sem sequência")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 4)
                    
                    
                    
                }
                
                
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(12.0)
                
            })
    }
}

struct CardThemeDay: View {
    var body: some View {
        NavigationLink(
            destination: ThemeView(tema: "Amarelo"),
            label : {
                
                VStack (alignment:.leading) {
                    
                    
                    HStack {
                        
                        Text("Tema do dia") .textCase(.uppercase)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    Text("Amarelo")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    
                    Text("15 de junho")
                        .font(.system(size: 13, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                }
                .padding()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 280, maxHeight: 280, alignment: .leading)
                
                .background(
                    Image("art05")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                )
                            
                            
                        )
                    
                )
                
                
                .cornerRadius(12.0)
                
            })
    }
}

struct CardGallery: View {
    var body: some View {
        NavigationLink(
            destination: GalleryView(photo: "diatal"),
            label : {
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: 370, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(12.0)
                        .foregroundColor(.white)
                    
                    HStack {
                        
                    }
                    
                    Image(systemName:"chevron.right")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                }
                //  .padding(.top,15)
            })
    }
}
