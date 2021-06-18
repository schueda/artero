//
//  PhotoRepository.swift
//  Artero
//
//  Created by André Schueda on 18/06/21.
//

import UIKit
import SwiftUI

protocol PhotoRepository {
    func save(image: UIImage, withIdentifier identifier: String)
    func deleteImage(withIdentifier identifier: String)
    func getImage(identifier: String) -> UIImage?
    func getImages() -> [UIImage]
}


class PhotoDocumentRepository: PhotoRepository {
    var fileManager = FileManager.default
    var documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    func save(image: UIImage, withIdentifier identifier: String) {
        if let data = image.pngData() {
            let url = documents.appendingPathComponent(identifier)

            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: identifier)
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
    }
    
    func deleteImage(withIdentifier identifier: String) {
        let url = documents.appendingPathComponent(identifier)
        
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print("Unable to delete file (\(error))")
        }
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
