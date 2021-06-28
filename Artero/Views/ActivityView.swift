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
        .navigationBarTitle(NSLocalizedString("activity", comment: ""))
    }
    
}
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
            .preferredColorScheme(.light)
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
                    
                    
                    Text(NSLocalizedString("current_sequence", comment: ""))
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundColor(.secondary)
                    
                    Text("15" + NSLocalizedString("days", comment: ""))
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(Color("text"))
                    
                }
                
                .padding()
                
            }
            
            Divider()
                .frame(width: 330, height: 0, alignment: .center)
            
            VStack (alignment: .leading)  {
                
                HStack {
                    
                    Image(systemName:"rosette")
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .foregroundColor(.blue)
                    
                    
                    VStack (alignment: .leading) {
                        
                        
                        Text(NSLocalizedString("longest_sequence", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                        
                        Text("23" + NSLocalizedString("days", comment: ""))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color("text"))
                        
                    }
                    .padding()
                    
                }
                
                
                
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 180, maxHeight: 180, alignment: .leading)
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
                        Text(NSLocalizedString("daily_reminder", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.vertical)
            
            Divider()
                .frame(width: 330, height: 0, alignment: .center)
            
            VStack (alignment: .leading)  {
                HStack {
                    VStack (alignment: .leading) {
                        Text(NSLocalizedString("time", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(Color("text"))
                            .padding(.vertical)
                    }
                    Spacer()
                    DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        
                }
                
                
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 120, maxHeight: 120, alignment: .leading)
        .padding()
        .background(Color("card"))
        .cornerRadius(12.0)
    }
    
}
