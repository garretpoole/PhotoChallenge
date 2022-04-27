//
//  Photo.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import Foundation

struct Photo: Identifiable, Codable {
    var id: UUID
    var name: String
    var imageData: Data
}
