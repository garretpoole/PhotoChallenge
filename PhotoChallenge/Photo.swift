//
//  Photo.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import Foundation
import SwiftUI

struct Photo: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    
    var image: Image? {
        let url = FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
                
        guard let uiImage = try? UIImage(data: Data(contentsOf: url)) else {
            print("Error creating UIImage from url \(url)")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    
}
