//
//  Topic.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

struct Theme: Codable {
    var id = UUID();
    var name: String;
    var description: String;
    var benefits: [String];
    var date: Date;
    var inspiration: Inspiration;
    
    static var themes: [Theme] = [
        Theme(name: NSLocalizedString("theme_name1", comment: ""), description: NSLocalizedString("description1", comment: ""), benefits: [NSLocalizedString("benefits1", comment: ""), NSLocalizedString("benefits2", comment: ""), NSLocalizedString("benefits3", comment: ""),NSLocalizedString("benefits4", comment: "")], date: Date(), inspiration: Inspiration(image: "art01", name: NSLocalizedString("art_name1", comment: ""), year: "1889", author: "Vincent Van Gogh")),
        Theme(name: NSLocalizedString("theme_name2", comment: ""), description: NSLocalizedString("description2", comment: ""), benefits: [NSLocalizedString("benefits5", comment: ""), NSLocalizedString("benefits6", comment: ""), NSLocalizedString("benefits7", comment: ""),NSLocalizedString("benefits8", comment: "")], date: Date(), inspiration: Inspiration(image: "art02", name: NSLocalizedString("art_name2", comment: ""), year: "40.000a.C", author: "--")),
        Theme(name: NSLocalizedString("theme_name3", comment: ""), description: NSLocalizedString("description3", comment: ""), benefits: [NSLocalizedString("benefits9", comment: ""), NSLocalizedString("benefits10", comment: ""), NSLocalizedString("benefits11", comment: ""),NSLocalizedString("benefits12", comment: "")], date: Date(), inspiration: Inspiration(image: "art03", name: NSLocalizedString("art_name3", comment: ""), year: "1506", author: "Leonardo da Vinci")),
        Theme(name: NSLocalizedString("theme_name4", comment: ""), description: NSLocalizedString("description4", comment: ""), benefits: [NSLocalizedString("benefits13", comment: ""), NSLocalizedString("benefits14", comment: ""), NSLocalizedString("benefits15", comment: ""),NSLocalizedString("benefits16", comment: "")], date: Date(), inspiration: Inspiration(image: "art04", name: NSLocalizedString("art_name4", comment: ""), year: "1505", author: "Hieronymus Bosh")),
        Theme(name: NSLocalizedString("theme_name5", comment: ""), description: NSLocalizedString("description5", comment: ""), benefits: [NSLocalizedString("benefits17", comment: ""), NSLocalizedString("benefits18", comment: ""), NSLocalizedString("benefits19", comment: ""),NSLocalizedString("benefits20", comment: "")], date: Date(), inspiration: Inspiration(image: "art05", name: NSLocalizedString("art_name5", comment: ""), year: "1928", author: "Tarsila do Amaral")),
        Theme(name: NSLocalizedString("theme_name6", comment: ""), description: NSLocalizedString("description6", comment: ""), benefits: [NSLocalizedString("benefits21", comment: ""), NSLocalizedString("benefits22", comment: ""), NSLocalizedString("benefits23", comment: ""),NSLocalizedString("benefits24", comment: "")], date: Date(), inspiration: Inspiration(image: "art06", name: NSLocalizedString("art_name6", comment: ""), year: "1974", author: "Michelangelo Pistoletto"))
        
    ];
}
