//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct ThemeView: View {

    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    private var theme: Theme?
    private var activity: Activity = Activity()
    
    func saveActivity() {
        guard let theme = self.theme,
              let data = self.selectedImage?.pngData() else {
            return;
        }
        let activity = Activity(theme: theme, date: Date(), image: data)
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
                Image("art05")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 420)
            }
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
                .padding(.bottom, 50)
            }
        }.ignoresSafeArea()
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
