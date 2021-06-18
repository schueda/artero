//
//  PhotoRepository.swift
//  Artero
//
//  Created by André Schueda on 18/06/21.
//

import UIKit
import SwiftUI

protocol PhotoRepository {
    func save(image: UIImage)
    func delete(imageURL: URL)
    func getImage(identifier: String) -> UIImage?
    func getImages() -> [UIImage]
}


class SandBox: PhotoRepository {
    func save(image: UIImage) {
        if let data = image.pngData() {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("landscape.png")

            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: "background")
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
    }
    
    func delete(imageURL: URL) {
        print("deletaria a imagem tal kkkk")
    }
    
    func getImage(identifier: String) -> UIImage? {
        guard let photoURL = UserDefaults.standard.url(forKey: identifier),
              let photoData = try? Data(contentsOf: photoURL),
              let image = UIImage(data: photoData) else {
            return nil
        }
        return image
    }
    
    func getImages() -> [UIImage] {
        return []
        
    }
    
    
}
