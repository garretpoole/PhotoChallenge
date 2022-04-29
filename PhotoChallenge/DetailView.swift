//
//  DetailView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/28/22.
//

import SwiftUI
import MapKit
import AVFAudio

struct LocationMarker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct DetailView: View {
    let photo: Photo
    
    var markers: [LocationMarker] {
            if let location = photo.location {
                return [LocationMarker(coordinate: location)]
            }
            return []
        }
    
    var body: some View {
        VStack(alignment: .leading){
            photo.image?
                .resizable()
                .scaledToFit()
            
            if let location = photo.location {
                VStack(alignment: .leading) {
                    Text("Location")
                        .font(.headline)
                        .padding(.horizontal)
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))), annotationItems: markers) { item in
                        MapPin(coordinate: item.coordinate)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
