//
//  SingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 26/06/21.
//

import SwiftUI

struct SingleActivityView: View {
    let activity: Activity?
    
    var body: some View {
        ScrollView {
            if let activity = activity {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    
                    Image(uiImage: activity.image ?? UIImage(systemName: "xmark.app.fill")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                        .clipped()
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text(NSLocalizedString("theme_was", comment: ""))
                                    .textCase(.uppercase)
                                    .font(.system(size: 12, weight: .bold, design: .default))
                                Text(activity.theme?.name ?? "")
                                    .font(.system(size: 28, weight: .bold, design: .default))
                            }
                            .padding(.bottom, 12)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                    }
                    .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(
                        NSLocalizedString("activity_from", comment: "") + " " +
                        DateUtils.formatToLong(date: activity?.date ?? Date(), languageCode: Locale.current.languageCode == "pt" ? "pt" : "en")
                    )
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.top, 10)
                    Spacer()
                }
                
                Text(activity?.theme?.description ?? "")
                    .font(.system(size: 17))
                    .padding(.top, 1)
                    .foregroundColor(.gray)
                
                Text(NSLocalizedString("benefits", comment: ""))
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                
                if let benefits = activity?.theme?.benefits {
                    ForEach(benefits, id: \.self) { benefit in
                        Text("• \(benefit)")
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
                    }
                }
                Text("")
                    .frame(height: 100)
                
            }.padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    // TODO
                }, label: {
                    Image(uiImage: UIImage(systemName: "trash")!)
                })
            }
        }
        .ignoresSafeArea()
    }
}
