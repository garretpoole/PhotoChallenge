//
//  PhotoCollection.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/27/22.
//

import Foundation

class PhotoCollection: ObservableObject {
    @Published var photos = [Photo]() {
        didSet {
            //save [Photo]
            do {
                let data = try JSONEncoder().encode(photos)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("photos.json")
    
    //loads data from disc
    init() {
        guard let data = try? Data(contentsOf: savePath) else {
            print("No existing saved data")
            photos = []
            return
        }
        guard let decodedPhotos = try? JSONDecoder().decode([Photo].self, from: data) else {
            print("Could not decode photos")
            return
        }
        photos = decodedPhotos
    }
}
