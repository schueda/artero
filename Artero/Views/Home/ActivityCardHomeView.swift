//
//  ActivityHomeCardView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct ActivityCardHomeView: View {
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
                        Text("\(current) " + NSLocalizedString(current == 1 ? "day_streak" : "days_streak", comment: ""))
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
