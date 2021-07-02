//
//  StreakCardView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct StreakCardActivityView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Image(systemName:"bolt.fill")
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .foregroundColor(.blue)
                VStack (alignment: .leading) {
                    Text(NSLocalizedString("current_streak", comment: ""))
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundColor(.secondary)
                    if let streak = viewModel.streak {
                        Text("\(streak.current) " + NSLocalizedString(streak.current == 1 ? "day" : "days", comment: ""))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color("text"))
                    } else {
                        Text(NSLocalizedString("no_streak", comment: ""))
                            .font(.system(size: 28, weight: .bold, design: .default))
                            .foregroundColor(Color("text"))
                    }
                }
                .padding()
            }
            
            Divider()
                .frame(width: 330, height: 0, alignment: .center)
            
            VStack (alignment: .leading)  {
                HStack {
                    Image(systemName:"rosette")
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .foregroundColor(.blue)
                    
                    VStack (alignment: .leading) {
                        Text(NSLocalizedString("longest_streak", comment: ""))
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                        if let streak = viewModel.streak {
                            Text("\(streak.best) " + NSLocalizedString(streak.current == 1 ? "day" : "days", comment: ""))
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .foregroundColor(Color("text"))
                        } else {
                            Text(NSLocalizedString("no_best", comment: ""))
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .foregroundColor(Color("text"))
                        }
                    }
                    .padding()
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 180, maxHeight: 180, alignment: .leading)
        .padding()
        .background(Color("card"))
        .cornerRadius(12.0)
    }
}
