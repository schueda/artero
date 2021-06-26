//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct ThemeView: View {
    private var theme: Theme?
    private var activity: Activity = Activity()
    @State private var selectedImage: UIImage?
    
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
        ScrollView {
            NavigationLink(
                destination: ImagePickerView(selectedImage: $selectedImage, sourceType: .photoLibrary),
                label : {
                    Text("gallery!")
                        .padding()
                })
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                Button("save") {
                    self.saveActivity()
                }
            }
            
            if let image = activity.image {
                Image(uiImage: image)
            }
        }
    }
}


struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
