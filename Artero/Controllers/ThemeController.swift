//
//  ThemeRepository.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 23/06/21.
//

import Foundation

protocol ThemeControllerProtocol {
    func get() -> Theme?
}

class ThemeController: ThemeControllerProtocol {
    func get() -> Theme? {
        let index = UserDefaultsThemeIndexRepository.shared.getIndex()
        print("index: \(index)")
        let theme = Theme.themes.first(where: { $0.index == index })
        return theme
    }
}

