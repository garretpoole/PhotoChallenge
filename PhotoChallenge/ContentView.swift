//
//  ContentView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    //final images
    @State private var photos: [Photo]
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
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    
    //loads data from disc
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            photos = []
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
