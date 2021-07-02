//
//  ActivityView.swift
//  Artero
//
//  Created by André Schueda on 20/06/21.
//

import UserNotifications
import SwiftUI

struct ActivityView: View {
    @StateObject var activityViewModel = ActivityViewModel(repository: UserDefaultsStreakRepository.shared)
    var body: some View {
        ScrollView {
            VStack (spacing:20) {
                StreakCardView(viewModel: activityViewModel)
                    .padding(.top, 25)
                RememberCardView()
            }
            .padding(.horizontal)
        }
        .background(Color("background").edgesIgnoringSafeArea(.bottom))
        .navigationBarTitle(NSLocalizedString("activity", comment: ""))
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
            .preferredColorScheme(.light)
    }
}


