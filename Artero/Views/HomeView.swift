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
            VStack (spacing:20) {
                CardThemeDay()
                    .padding(.top, 25)
                CardActivityView()
                CardGallery()
                    .padding(.bottom, 25)
            }
        }
        .padding(.horizontal)
        .navigationBarTitle(NSLocalizedString("good_morning", comment: ""))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .preferredColorScheme(.light)
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
                        
                        Text(NSLocalizedString("activity", comment: "")) .textCase(.uppercase)
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                    }
                    
                    Text(NSLocalizedString("no_sequence", comment: ""))
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(Color("text"))
                        
                        .padding(.top, 4)
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 85, maxHeight: 85, alignment: .leading)
                .padding()
                .background(Color("card"))
                .cornerRadius(12.0)
                
            }
        )
    }
}

struct CardThemeDay: View {
    @State var theme = ThemeController().getToday()
    
    var body: some View {
        NavigationLink(
            destination: ThemeView(theme: theme),
            label : {
                VStack (alignment:.leading) {
                    HStack {
                        
                        Text(NSLocalizedString("daily_theme", comment: "")) .textCase(.uppercase)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    Text(NSLocalizedString(theme?.name ?? "", comment: ""))
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(DateUtils.formatToLong(date: Date(), languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                        .font(.system(size: 13, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                
                .background(
                    Image(theme?.inspiration.image ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
                .onAppear {
                    self.theme = ThemeController().getToday()
                }
            }
        )
    }
}

struct CardGallery: View {
    @State var galleryImage = UIImage(named: "GalleryPlaceholder")!
    @State var activities = ActivityController().getAll()
    
    var body: some View {
        NavigationLink(
            destination: GalleryView(),
            label : {
                VStack (alignment:.trailing) {
                    Image(systemName:"chevron.right")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 170, maxHeight: 170, alignment: .topTrailing)
                
                .background(
                    Image(uiImage: galleryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, ]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
                .onAppear {
                    self.activities = ActivityController().getAll()
                    if activities.count > 0 && activities[0].image != nil {
                        self.galleryImage = activities[0].image!
                    } else {
                        self.galleryImage = UIImage(named: "GalleryPlaceholder")!
                    }
                }
            }
        )
    }
}
