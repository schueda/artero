//
//  ContentView.swift
//  app das frutas
//
//  Created by André Schueda on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var savedImage: UIImage?
    @State private var openOnboarding = false
    
    private var notificationPreference: NotificationPreference = NotificationPreference()
    
    var body: some View {
        if openOnboarding{
            NavigationView {
                ScrollView {

                    VStack {
                        HomeView()
                            .navigationTitle("home-view")
                    }

                }
                .background(Color("background").edgesIgnoringSafeArea(.bottom))
                
            }
        }else{
            NavigationView {
                OnboardingView().navigationBarHidden(true)
            }

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
