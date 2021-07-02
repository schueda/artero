//
//  DayView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import SwiftUI
import UIKit
import AVFoundation

struct ThemeView: View {
    @StateObject var galleryViewModel = GalleryViewModel(repository: UserDefaultsActivityRepository.shared)
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var isFeedbackShowing = false
    @State private var isGalleryShowing = false
    
    @ObservedObject var viewModel: ThemeViewModel
    @Binding var theme: Theme?
    
    init(viewModel: ThemeViewModel, theme: Binding<Theme?>) {
        self.viewModel = viewModel
        self._theme = theme
        
        var activity = Activity(theme: Theme.themes[4], date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, image: UIImage(named: "bumba")!)
        viewModel.save(activity: activity)
        activity = Activity(theme: Theme.themes[1], date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, image: UIImage(named: "s2")!)
        viewModel.save(activity: activity)
        activity = Activity(theme: Theme.themes[2], date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, image: UIImage(named: "d3")!)
        viewModel.save(activity: activity)
        activity = Activity(theme: Theme.themes[3], date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, image: UIImage(named: "s1")!)
        viewModel.save(activity: activity)
    }
    
    var body: some View {
        if let theme = theme {
            ZStack {
                ScrollView {
                    HeaderThemeView(theme: theme)
                    TextThemeView(theme: theme)
                    
                }
                VStack {
                    Spacer()
                    if viewModel.currentDayActivity != nil {
                        FakeButtonThemeView()
                    } else {
                        if selectedImage != nil {
                            ConfirmButtonThemeView(theme: theme, selectedImage: $selectedImage, isFeedbackShowing: $isFeedbackShowing) { activity in
                                viewModel.save(activity: activity)
                            }
                        } else {
                            CameraButtonThemeView(sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
                        }
                    }
                }
                if isFeedbackShowing {
                    FeedbackThemeView(isGalleryShowing: $isGalleryShowing, isFeedbackShowing: $isFeedbackShowing)
                }
                NavigationLink(destination: GalleryView(viewModel: galleryViewModel), isActive: $isGalleryShowing, label: {})
            }
            .animation(.easeInOut)
            .ignoresSafeArea()
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.$sourceType)
            }
        } else {
            Rectangle()
                .foregroundColor(.red)
        }
    }
}
