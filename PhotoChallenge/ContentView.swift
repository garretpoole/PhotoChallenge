//
//  ContentView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    //data is saved on disc (takes up phone storage) and much more flexible than UserDefaults
    let savePath = FileManager.documentsDirectory.appendingPathComponent("photos.json")
    
    //final images
    @ObservedObject var collection = PhotoCollection()
    @State private var image: Image?
    @State private var name = ""
    
    //image picker
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var cannotSave = true
    let context = CIContext()
    
    //name the image
    @State private var choosingName = false
    @State private var saveName = false
    
    //location of image
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        if choosingName {
            EditNameView(image: image, name: $name, saveName: $saveName, choosingName: $choosingName)
                .onChange(of: saveName) { _ in
                    save()
                }
        } else {
            NavigationView {
                ScrollView {
                    ForEach(collection.photos.sorted()) { photo in
                        NavigationLink {
                            DetailView(photo: photo)
                        } label: {
                            VStack {
                                photo.image?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .padding()
                                Text(photo.name)
                                    .font(.headline)
                            }
                        }
                    }
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
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage, cannotSave: $cannotSave)
                }
            }
        }
    }
    
    //file can only be read when device is requested to be unlocked
    func save() {
        //save Image
        let imageSaver = ImageSaver()
        var newPhoto = Photo(id: UUID(), name: name)
        if let location = locationFetcher.lastKnownLocation {
            newPhoto.setLocation(location: location)
        } else {
            print("location unknown")
        }
        guard let uiImage = inputImage else { return }
        imageSaver.writeToSecureDirectory(uiImage: uiImage, id: newPhoto.id.uuidString)
        //save [Photo] when setting PhotoCollection
        collection.photos.append(newPhoto)
        
        choosingName = false
        name = ""
    }
    
    func loadImage() {
        //need image for displaying in EditNameView
        guard let uiImage = inputImage else { return }
        image = Image(uiImage: uiImage)
        locationFetcher.start()
        choosingName = true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
