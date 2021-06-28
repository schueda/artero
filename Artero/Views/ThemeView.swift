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
    @State private var isTodayActivitySent = ActivityController().getTodayActivity() != nil
    
    var theme: Theme?
    private var activity: Activity = Activity()
    
    mutating func loadDayActivity() {
        let repository = ActivityController()
        if let activity = repository.getTodayActivity() {
            self.activity = activity
        }
    }
    
    init(theme: Theme?) {
        self.theme = theme
        self.loadDayActivity()
    }
    
    var body: some View {
        if let theme = theme {
            ZStack {
                ScrollView {
                    ThemeHeaderView(theme: theme)
                    ThemeTextView(theme: theme)
                    
                }
                if isTodayActivitySent {
                    FakeButtonView()
                } else {
                    if selectedImage != nil {
                        ConfirmButtonView(theme: theme, selectedImage: $selectedImage, isTodayActivitySent: $isTodayActivitySent)
                    } else {
                        CameraButtonView(sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
                    }
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.$sourceType)
            }
        }
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

struct FakeButtonView: View {
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                
            }, label: {
                HStack {
                    Text("Arte enviada")
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .font(.system(size: 17, weight: .semibold, design: .default))
                .foregroundColor(.white)
                .background(Color(.gray))
                .cornerRadius(10.0)
            })
            .padding(.horizontal)
            .padding(.bottom, UIScreen.main.bounds.height * 0.05)
            .disabled(true)
        }
    }
}


struct ConfirmButtonView: View {
    func saveActivity() {
        guard let theme = self.theme,
              let image = self.selectedImage
        else {
            print("salvou nada")
            return;
        }
        let activity = Activity(theme: theme, date: Date(), image: image)
        activity.save(activity)
    }
    
    let theme: Theme?
    
    @Binding var selectedImage: UIImage?
    @Binding var isTodayActivitySent: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Menu(content: {
                Button(action: {
                    selectedImage = nil
                }, label: {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("Cancelar")
                    }
                })
                Button(action: {
                    isTodayActivitySent = true
                    self.saveActivity()
                    
                }, label: {
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Confirmar")
                    }
                })
            }, label: {
                HStack {
                    Text("")
                        .frame(width: 36, height: 36)
                        .padding(.leading)
                    Spacer()
                    Text("Confirmar")
                    Spacer()
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 36, height: 36)
                            .cornerRadius(4)
                            .clipped()
                            .padding(.trailing)
                    } else {
                        Text("")
                            .frame(width: 36, height: 36)
                            .padding(.trailing)
                    }
                    
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
            
            NavigationLink(destination: ImageView(image: UIImage(named: theme.inspiration.image)!, activity: nil)) {
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
            }
            
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
    let date: Date?
    
    init(theme: Theme, date: Date? = nil) {
        self.theme = theme
        self.date = date
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if date == nil {
                    Text(NSLocalizedString("activity_of_today", comment: ""))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.top, 10)
                } else {
                    Text(NSLocalizedString("activity_from", comment: "") + " " +
                         DateUtils.formatToLong(date: date!, languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.top, 10)
                }
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
