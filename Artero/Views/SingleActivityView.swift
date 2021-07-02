//
//  SingleActivityView.swift
//  Artero
//
//  Created by André Schueda on 26/06/21.
//

import SwiftUI

struct SingleActivityView: View {
    @ObservedObject var viewModel: SingleActivityViewModel
    let activity: Activity?
    
    @State var isDeleted = false
    @State var showingAlert = false
    
    var body: some View {
        ScrollView {
            if let activity = activity {
                HeaderSingleActivityView(activity: activity)
                if let theme = activity.theme {
                    TextThemeView(theme: theme, date: activity.date)
                }
                DeleteButtonSingleActivityView(activity: activity) { activity in
                    viewModel.delete(activity)
                }
            }
        }
        .ignoresSafeArea()
    }
}

