//
//  PhotoCollection.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/27/22.
//

import Foundation

class PhotoCollection: ObservableObject {
    @Published var photos = [Photo]()
}
