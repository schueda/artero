//
//  TextThemeView.swift
//  Artero
//
//  Created by André Schueda on 01/07/21.
//

import Foundation
import SwiftUI

struct TextThemeView: View {
    let theme: Theme
    let date: Date?
    
    init(theme: Theme, date: Date? = nil) {
        self.theme = theme
        self.date = date
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if date == nil {
                    Text(NSLocalizedString("activity_of_today", comment: ""))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.top, 10)
                } else {
                    Text(NSLocalizedString("activity_from", comment: "") + " " +
                            DateUtils.formatToLong(date: date!, languageCode: Locale.current.languageCode == "pt" ? "pt" : "en"))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.top, 10)
                }
                Spacer()
                
            }
            
            Text(theme.description)
                .font(.system(size: 17))
                .padding(.top, 1)
                .foregroundColor(.gray)
            
            Text(NSLocalizedString("benefits", comment: ""))
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding(.top, 10)
                .padding(.bottom, 5)
            
            if let benefits = theme.benefits {
                ForEach(benefits, id: \.self) { benefit in
                    Text("• \(benefit)")
                        .padding(.bottom, 1)
                        .foregroundColor(.gray)
                }
            }
            Text("")
                .frame(height: 100)
            
        }.padding()
    }
}

