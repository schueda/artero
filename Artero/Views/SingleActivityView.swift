//
//  SingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 26/06/21.
//

import SwiftUI

struct SingleActivityView: View {
    let activity: Activity?
    
    @State var isDeleted = false
    @State var showingAlert = false
    
    var body: some View {
        ScrollView {
            if let activity = activity {
                SingleActivityHeaderView(activity: activity)
                if let theme = activity.theme {
                    ThemeTextView(theme: theme, date: activity.date)
                }
                DeleteButton(activity: activity)
            }
        }
        .ignoresSafeArea()
    }
}

struct SingleActivityHeaderView: View {
    let activity: Activity
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            
            NavigationLink(destination: ImageView(image: activity.image ?? UIImage(systemName: "xmark.app.fill")!, activity: activity)) {
                Image(uiImage: activity.image ?? UIImage(systemName: "xmark.app.fill")!)
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
                        Text(NSLocalizedString("theme_was", comment: ""))
                            .textCase(.uppercase)
                            .font(.system(size: 12, weight: .bold, design: .default))
                        Text(activity.theme?.name ?? "")
                            .font(.system(size: 28, weight: .bold, design: .default))
                    }
                    .padding(.bottom, 12)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
}

struct DeleteButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    let activity: Activity
    @State var showingAlert = false
    
    var body: some View {
        Button(action: {
            showingAlert.toggle()
        }, label: {
            HStack {
                Image(systemName: "trash")
                Text(NSLocalizedString("delete_activity", comment: ""))
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .font(.system(size: 17, weight: .semibold, design: .default))
            .foregroundColor(.white)
            .background(Color(.red))
            .cornerRadius(10.0)
            .padding(.horizontal)
            .padding(.bottom, 50)
        })
        .alert(isPresented: $showingAlert) { () -> Alert in
            Alert(
                title: Text(NSLocalizedString("delete_activity", comment: "")),
                message: Text(NSLocalizedString("delete_question", comment: "")),
                primaryButton: .default(Text(NSLocalizedString("delete", comment: "")), action: {
//                    ActivityDAO().delete(activity)
                    // TODO arrumar
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text(NSLocalizedString("cancel", comment: "")))
            )
        }
    }
}
