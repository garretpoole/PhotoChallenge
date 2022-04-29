//
//  DetailView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/28/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let photo: Photo
    
//    var mapRegion: MKCoordinateRegion? {
//        guard let center = photo.location else {
//            return nil
//        }
//        return MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
//    }
    
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
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))))
                        
                    }
                }
            }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
