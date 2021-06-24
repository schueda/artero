//
//  Inspiration.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

struct Inspiration: Codable {
    var id = UUID();
    var image: String;
    var name: String;
    var year: String;
}
