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
                if viewModel.currentDayActivity != nil {
                    CardThemeDay(frameHeight: 170)
                        .padding(.top, 25)
                } else {
                    CardThemeDay(frameHeight: 280)
                        .padding(.top, 25)
                }
                CardActivityView(streak: $viewModel.streak)
                
                if viewModel.currentDayActivity != nil {
                    CardGallery(frameHeight: 280, activities: $viewModel.activities)
                        .padding(.bottom, 25)
                } else {
                    CardGallery(frameHeight: 170, activities: $viewModel.activities)
                        .padding(.bottom, 25)
                }
                
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

struct CardActivityView: View {
    @Binding var streak: Streak?
    
    var body: some View {
        NavigationLink(
            destination: ActivityView(),
            label : {
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName:"sparkles")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.yellow)
                        
                        Text(NSLocalizedString("activity", comment: "")) .textCase(.uppercase)
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                    }
                    if let current = streak?.current,
                       current > 0 {
                        Text("\(current) " + NSLocalizedString("days", comment: ""))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color("text"))
                            .padding(.top, 4)
                    } else {
                        Text(NSLocalizedString("no_streak", comment: ""))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color("text"))
                            .padding(.top, 4)
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 85, maxHeight: 85, alignment: .leading)
                .padding()
                .background(Color("card"))
                .cornerRadius(12.0)
            }
        )
    }
}

struct CardThemeDay: View {
    let frameHeight: CGFloat
    
    let theme = ThemeController().getToday()
    
    var body: some View {
        NavigationLink(
            destination: ThemeView(viewModel: ThemeViewModel(activityRepository: UserDefaultsActivityRepository.shared, streakRepository: UserDefaultsStreakRepository.shared), theme: theme),
            label : {
                VStack (alignment:.leading) {
                    HStack {
                        
                        Text(NSLocalizedString("daily_theme", comment: "")) .textCase(.uppercase)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName:"chevron.right")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        
                    }
                    
                    Text(NSLocalizedString(theme?.name ?? "", comment: ""))
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        Text(DateUtils.formatToLong(date: Date(), languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                            .font(.system(size: 13, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                        if frameHeight == 170 {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: frameHeight, maxHeight: frameHeight, alignment: .leading)
                
                .background(
                    Image(theme?.inspiration.image ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
            }
        )
    }
}

struct CardGallery: View {
    let frameHeight: CGFloat
    
    @Binding var activities: [Activity]
    
    var galleryImage: UIImage {
        guard let activity = activities.first,
              let image = activity.image else {
            return UIImage(named: "GalleryPlaceholder")!
        }
        return image
    }
    
    var body: some View {
        NavigationLink(
            destination: GalleryView(viewModel: GalleryViewModel(repository: UserDefaultsActivityRepository.shared)),
            label : {
                VStack (alignment:.trailing) {
                    Image(systemName:"chevron.right")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: frameHeight, maxHeight: frameHeight, alignment: .topTrailing)
                
                .background(
                    Image(uiImage: galleryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 280, maxHeight: 280, alignment: .leading)
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear, Color.clear, ]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                )
                .cornerRadius(12.0)
            }
        )
    }
}
