//
//  CameraButtonThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//


import SwiftUI
import AVFoundation

struct CameraButtonThemeView: View {
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var isImagePickerDisplay: Bool
    @State var showEnableCameraAlert = false
    
    private func checkCameraPermissions() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .notDetermined:
            self.askCameraPermission()
        case .authorized:
            self.showCamera()
        case .restricted, .denied:
            self.showCameraAccessAlert()
        @unknown default:
            self.showCameraAccessAlert()
        }
    }
    
    private func enableCameraAlert() -> Alert {
        return Alert (
            title: Text(NSLocalizedString("enable_camera_alert_title", comment: "")),
            message: Text(NSLocalizedString("enable_camera_alert_description", comment: "")),
            primaryButton: .default(Text(NSLocalizedString("settigns", comment: "")), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
            secondaryButton: .cancel()
        )
    }
    
    private func askCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
            if accessGranted {
                self.showCamera()
            } else {
                self.showCameraAccessAlert()
            }
        })
    }
    
    private func showCameraAccessAlert() {
        self.showEnableCameraAlert = true
    }
    
    private func showCamera() {
        self.sourceType = .camera
        self.isImagePickerDisplay.toggle()
    }
    
    
    var body: some View {
        Menu(content: {
            Button(action: {
                self.checkCameraPermissions()
            }, label: {
                HStack {
                    Image(systemName: "camera")
                    Text(NSLocalizedString("button_take_a_picture", comment: ""))
                }
            })
            Button(action: {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }, label: {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text(NSLocalizedString("button_choose_media", comment: ""))
                }
            })
        }, label: {
            HStack {
                Image(systemName: "camera")
                Text(NSLocalizedString("button_media", comment: ""))
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .font(.system(size: 17, weight: .semibold, design: .default))
            .foregroundColor(.white)
            .background(Color(.link))
        })
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10.0)
        .padding(.horizontal)
        .padding(.bottom, UIScreen.main.bounds.height * 0.05)
        .alert(isPresented: $showEnableCameraAlert, content: { self.enableCameraAlert() })
    }
}
