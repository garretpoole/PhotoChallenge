//
//  ContentView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    //final image
    @State private var image: Image?
    //image picker
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var cannotSave = true
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            List {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("Photos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingImagePicker.toggle()
                    } label: {
                        Label("Add Photo", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage, cannotSave: $cannotSave)
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        guard let beginImage = CIImage(image: inputImage) else { return }
        if let cgimg = context.createCGImage(beginImage, from: beginImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
