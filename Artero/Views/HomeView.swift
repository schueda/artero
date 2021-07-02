//
//  HomeView.swift
//  Artero
//
//  Created by Mariana Florencio on 23/06/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var welcomeTitle = NSLocalizedString("good_morning", comment: "")
    
    private func getWelcomeTitle() -> String {
        let date = Date()
        let time = DateUtils.dateToString(date: date, format: "HH:mm")
        let hourAndMinute = time.split(separator: ":")
        guard let hour = Int(hourAndMinute[0]) else {
            return NSLocalizedString("good_morning", comment: "")
        }
        
        switch hour {
        case 6...11:
            return "☀️ \(NSLocalizedString("good_morning", comment: ""))"
        case 12...17:
            return "🌤 \(NSLocalizedString("good_afternoon", comment: ""))"
        case 18...23:
            return "🌙 \(NSLocalizedString("good_evening", comment: ""))"
        default:
            return "🌙 \(NSLocalizedString("good_night", comment: ""))"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing:20) {
                ThemeCardHomeView(theme: $viewModel.theme, currentDayActivity: $viewModel.currentDayActivity)
                    .padding(.top, 25)
                    
                ActivityCardHomeView(streak: $viewModel.streak)
                
                GalleryCardHomeView(currentDayActivity: $viewModel.currentDayActivity, activities: $viewModel.activities)
                    .padding(.bottom, 25)
                
            }
            .padding(.horizontal)
            
        }
        .fixFlickering()
        .background(Color("background").edgesIgnoringSafeArea(.bottom))
        .navigationBarTitle(self.welcomeTitle)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.welcomeTitle = self.getWelcomeTitle()
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            HomeView()
//        }
//        .preferredColorScheme(.light)
//    }
//}
