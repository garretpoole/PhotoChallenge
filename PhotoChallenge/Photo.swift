//
//  Photo.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import Foundation
import SwiftUI

struct Photo: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var imageData: Data
    
    var image: Image? {
        Image(uiImage: UIImage(data: imageData) ?? UIImage())
    }
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}
