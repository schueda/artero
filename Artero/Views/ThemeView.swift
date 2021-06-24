//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI

struct ThemeView: View {
    private var theme: Theme?
//    private var activityRepository = ActivityRepository()
    var photoRepository: PhotoRepository = PhotoDocumentRepository()
    @State private var selectedImage: UIImage?
    private var activity: Activity2 = Activity2()
    
    func saveActivity() {
        guard let theme = self.theme,
              let data = self.selectedImage?.pngData() else {
            return;
        }
        let activity = Activity2(theme: theme, date: Date(), image: data)
        activity.save(activity)
        print("saved")
    }
    
    mutating func loadDayActivity() {
        print("trying to load")
        let repository = ActivityRepository2()
        if let activity = repository.getTodayActivity() {
            self.activity = activity
            print("loaded")
        }
    }
    
    init() {
        let themeRepository = ThemeRepository()
        self.theme = themeRepository.getToday()
        self.loadDayActivity()
    }
    
    var body: some View {
        ScrollView {
            NavigationLink(
                destination: ImagePickerView(selectedImage: $selectedImage, sourceType: .photoLibrary),
                label : {
                    Text("camera!")
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
            
            if let image = activity.image, let uiImage = UIImage(data: image) {
                Image(uiImage: uiImage)
            }
        }
    }
}


struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
