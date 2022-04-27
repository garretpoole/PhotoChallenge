//
//  ContentView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    //final images
    @ObservedObject var collection = PhotoCollection()
    @State private var image: Image?
    @State private var label = ""
    
    //image picker
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var cannotSave = true
    let context = CIContext()
    
    //name the image
    @State private var choosingLabel = false
    
    //data is saved on disc (takes up phone storage) and much more flexible than UserDefaults
    let savePath = FileManager.documentsDirectory.appendingPathComponent("photos.json")
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(collection.photos.sorted()) { photo in
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
            .sheet(isPresented: $choosingLabel) {
                VStack{
                    image?
                        .resizable()
                        .scaledToFit()
                    TextField("Name", text: $label)
                        .padding(.horizontal)
                        .font(.title)
                    HStack {
                        Button("Save") {
                            save()
                        }
                        .frame(width: 100, height: 40)
                        .background(.blue)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        
                        Button("Cancel") {
                            choosingLabel = false
                        }
                        .frame(width: 100, height: 40)
                        .background(.red)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                    }
                    
                }
                .padding([.horizontal, .vertical])
            }
            
        }
    }
    
    //loads data from disc
    init() {
        print("url: \(savePath)")
        
        guard let data = try? Data(contentsOf: savePath) else {
            print("fails here so no images")
            collection.photos = []
            return
        }
        guard let decodedPhotos = try? JSONDecoder().decode([Photo].self, from: data) else {
            print("Failed Here")
            return
        }
        collection.photos = decodedPhotos
        print("can load")
        
    }
    
    //file can only be read when device is requested to be unlocked
    func save() {
        //save Image
        let imageSaver = ImageSaver()
        let newPhoto = Photo(id: UUID(), name: label)
        guard let uiImage = inputImage else { return }
        
        imageSaver.writeToSecureDirectory(uiImage: uiImage, id: newPhoto.id.uuidString)
        collection.photos.append(newPhoto)
        
        //save [Photo]
        do {
            let data = try JSONEncoder().encode(collection.photos)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
        
        label = ""
        choosingLabel = false
    }
    
    func loadImage() {
        guard let uiImage = inputImage else { return }
        image = Image(uiImage: uiImage)
        choosingLabel = true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
