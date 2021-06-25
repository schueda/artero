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
            
            VStack (spacing:20) {
                
                SequenceCardView()
                    .padding(.top, 25)
                RememberCardView()
                
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Atividade")
    }
    
}
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
            .preferredColorScheme(.dark)
    }
}

struct SequenceCardView: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack {
                
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
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 180, maxHeight: 180, alignment: .leading)
        .padding()
        .background(Color("card"))
        .cornerRadius(12.0)
    }
}

struct RememberCardView:View {
    @State private var isToggle : Bool = false
    @State private var wakeUp = Date()
    
    var body: some View {
        
        
        VStack (alignment: .leading) {
            
            HStack {
                
                Image(systemName:"bell.fill")
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .foregroundColor(.blue)
                
                
                VStack (alignment: .leading) {
                    
                    Toggle (isOn: $isToggle) {
                        Text("Lembrete diário")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                            .padding(.vertical)
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            .padding(.horizontal)
            
            Divider()
                .frame(width: 330, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .leading)  {
                
                HStack {

                    
                    VStack (alignment: .leading) {
                        
                        
                        Text("Hora")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(Color("text"))
                            .padding(.vertical)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                        
                }
                
                
            }
            
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 120, maxHeight: 120, alignment: .leading)
        .padding()
        .background(Color("card"))
        .cornerRadius(12.0)
    }
    
}
