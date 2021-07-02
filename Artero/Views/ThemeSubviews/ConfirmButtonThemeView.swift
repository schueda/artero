//
//  ConfirmButtonThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct ConfirmButtonThemeView: View {
    func saveActivity() {
        guard let theme = self.theme,
              let image = self.selectedImage
        else {
            return;
        }
        let activity = Activity(theme: theme, date: Date(), image: image)
        onSave(activity)

    }
    
    let theme: Theme?
    
    @Binding var selectedImage: UIImage?
    @Binding var isFeedbackShowing: Bool
    let onSave: (Activity) -> Void

    var body: some View {
        Menu(content: {
            Button(action: {
                selectedImage = nil
            }, label: {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text(NSLocalizedString("cancel", comment: ""))
                }
            })
            Button(action: {
                isFeedbackShowing = true
                self.saveActivity()
                
                let seconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    isFeedbackShowing = false
                }
                
            }, label: {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text(NSLocalizedString("confirm", comment: ""))
                }
            })
        }, label: {
            HStack {
                Text("")
                    .frame(width: 36, height: 36)
                    .padding(.leading)
                Spacer()
                Text(NSLocalizedString("confirm", comment: ""))
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
        })
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10.0)
        .padding(.horizontal)
        .padding(.bottom, UIScreen.main.bounds.height * 0.05)
    }
}
