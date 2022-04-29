//
//  Photo.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//
import CoreLocation
import Foundation
import MapKit
import SwiftUI

struct Photo: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    
    var image: Image? {
        let url = FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
                
        guard let uiImage = try? UIImage(data: Data(contentsOf: url)) else {
            print("Error creating UIImage from url \(url)")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    var location: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    
}
