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
