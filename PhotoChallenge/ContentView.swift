//
//  ContentView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    //final images
    @State private var photos = [Photo]()
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
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(photos) { photo in
                    VStack {
                        photo.image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity, height: 150)
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
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
            print("can load")
        } catch {
            print("cannot load")
            photos = []
        }
    }
    
    //file can only be read when device is requested to be unlocked
    func save() {
        do {
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                let photo = Photo(id: UUID(), name: label, imageData: jpegData)
                photos.append(photo)
                print("appended")
            }
            
            let data = try JSONEncoder().encode(photos)
            //.completeFileProtection ensures files are stored with strong encryption
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Saved")
        } catch {
            print("Unable to save data.")
        }
        choosingLabel = false
    }
    
    func loadImage() {
        guard let uiImage = inputImage else { return }
        image = Image(uiImage: uiImage)
        choosingLabel = true
    }

    
//    func save() {
//        guard let inputImage = inputImage else { return }
//        let imageSaver = ImageSaver()
//
//        imageSaver.successHandler = {
//            print("Success!")
//        }
//        imageSaver.errorHandler = {
//            print("Oops! \($0.localizedDescription)")
//        }
//        imageSaver.writeToPhotoAlbum(image: inputImage)
//
//    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
