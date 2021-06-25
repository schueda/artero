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
        Theme(name: "Amarelo", description: "Explore o amarelo no seu dia! Hoje temos a sugestão você dancar bem feliz uma música que te lembre amarelo", benefits: ["A danca é muito massa uhu", "Estimula seu corpo lalala"], date: Date(), inspiration: Inspiration(image: "sunflower", name: "Sunflowers", year: "1889"))
    ];
}
