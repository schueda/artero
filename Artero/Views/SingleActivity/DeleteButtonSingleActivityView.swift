//
//  DeleteButtonSingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct DeleteButtonSingleActivityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let activity: Activity
    @State var showingAlert = false
    let onDelete: (Activity) -> Void
    
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
                    onDelete(activity)
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text(NSLocalizedString("cancel", comment: "")))
            )
        }
    }
}
