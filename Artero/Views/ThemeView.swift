//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI
import UIKit

struct ThemeView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    private var theme: Theme?
    private var activity: Activity = Activity()
    
    func saveActivity() {
        guard let theme = self.theme,
              let image = self.selectedImage
        else {
            return;
        }
        let activity = Activity(theme: theme, date: Date(timeIntervalSince1970: 21301), image: image)
        activity.save(activity)
    }
    
    
    mutating func loadDayActivity() {
        let repository = ActivityController()
        if let activity = repository.getTodayActivity() {
            self.activity = activity
        }
    }
    
    init() {
        self.theme = ThemeController().getToday()
        self.loadDayActivity()
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                if let theme = theme {
                    ThemeHeaderView(theme: theme)
                    ThemeTextView(theme: theme)
                }
                
            }
            Button("save") {
                self.saveActivity()
            }
            CameraButtonView(sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.$sourceType)
        }
    }
}


struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}

struct CameraButtonView: View {
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var isImagePickerDisplay: Bool
    
    
    var body: some View {
        VStack {
            Spacer()
            Menu(content: {
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Tirar foto")
                    }
                })
                Button(action: {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        Text("Escolher foto ou vídeo")
                    }
                })
            }, label: {
                HStack {
                    Image(systemName: "camera")
                    Text("Adicionar mídia")
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .font(.system(size: 17, weight: .semibold, design: .default))
                .foregroundColor(.white)
                .background(Color(.link))
                .cornerRadius(10.0)
            })
            .padding(.horizontal)
            .padding(.bottom, UIScreen.main.bounds.height * 0.05)
        }
    }
}

struct ThemeHeaderView: View {
    let theme: Theme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            
            Image(theme.inspiration.image)
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
                        Text(NSLocalizedString("daily_theme", comment: ""))
                            .textCase(.uppercase)
                            .font(.system(size: 12, weight: .bold, design: .default))
                        Text(theme.name)
                            .font(.system(size: 28, weight: .bold, design: .default))
                    }
                    .padding(.bottom, 12)
                    
                    Spacer()
                    
                    Text("\(theme.inspiration.name) | \(theme.inspiration.year)")
                        .font(.system(size: 13, weight: .bold, design: .default))
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
}

struct ThemeTextView: View {
    let theme: Theme
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(NSLocalizedString("activity_of_today", comment: ""))
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.top, 10)
                Spacer()
            }
            
            Text(theme.description)
                .font(.system(size: 17))
                .padding(.top, 1)
                .foregroundColor(.gray)
            
            Text(NSLocalizedString("benefits", comment: ""))
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding(.top, 10)
                .padding(.bottom, 5)
            
            if let benefits = theme.benefits {
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
}
