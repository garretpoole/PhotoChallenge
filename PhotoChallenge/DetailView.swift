//
//  DetailView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/28/22.
//

import SwiftUI

struct DetailView: View {
    let image: Image?
    let name: String
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
