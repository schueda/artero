//
//  ActivityView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct ActivityView: View {
    
    var body: some View {
        
        
        ScrollView {
            
            ZStack {
                
                Rectangle()
                    .frame(width: 370, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(12.0)
                    .foregroundColor(Color("card"))
                    .padding(10)
                
                VStack (alignment: .leading) {
                    
                    HStack  {
                        
                        Image(systemName:"bolt.fill")
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .foregroundColor(.blue)
                        
                        
                        VStack (alignment: .leading) {
                            
                            
                            Text("Sequência atual")
                                .font(.system(size: 17, weight: .semibold, design: .default))
                                .foregroundColor(.secondary)
                            
                            Text("15 dias")
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .foregroundColor(Color("text"))
                            
                        }
                        
                        .padding()
                        
                    }
                    
                    Divider()
                        .frame(width: 330, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    VStack (alignment: .leading)  {
                        
                        HStack {
                            
                            Image(systemName:"rosette")
                                .font(.system(size: 36, weight: .bold, design: .default))
                                .foregroundColor(.blue)
                            
                            
                            VStack (alignment: .leading) {
                                
                                
                                Text("Maior sequência")
                                    .font(.system(size: 17, weight: .semibold, design: .default))
                                    .foregroundColor(.secondary)
                                
                                Text("23 dias")
                                    .font(.system(size: 28, weight: .bold, design: .default))
                                    .foregroundColor(Color("text"))
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    
                }
                
            }
            
            VStack {
                Image("calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 370, height: 340, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(12.0)
                    .padding(4)
                
            }
            
        }
        .navigationBarTitle("Atividade")
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
