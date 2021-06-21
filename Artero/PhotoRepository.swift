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
    static var identifiersKey: String = "keys"
    var fileManager = FileManager.default
    var documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    var keys: [String] {
        UserDefaults.standard.array(forKey: Self.identifiersKey) as? [String] ?? []
    }
    
    func save(image: UIImage, withIdentifier identifier: String) {
        if let data = image.pngData() {
            let url = documents.appendingPathComponent(identifier)

            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: identifier)
                addKey(key: identifier)
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
    }
    
    func deleteImage(withIdentifier identifier: String) {
        let url = documents.appendingPathComponent(identifier)
        
        do {
            try fileManager.removeItem(at: url)
            deleteKey(key: identifier)
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
        keys.compactMap { getImage(identifier: $0) }
    }
    
    fileprivate func addKey(key: String) {
        var keys = self.keys
        keys.append(key)
        UserDefaults.standard.setValue(keys, forKey: Self.identifiersKey)
        
    }
    
    fileprivate func deleteKey(key: String) {
        var keys = self.keys
        keys.removeAll { $0 == key }
    }
}
