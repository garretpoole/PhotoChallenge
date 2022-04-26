//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Garret Poole on 4/14/22.
//

import PhotosUI
import SwiftUI

//makes view that can go inside swiftUI
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    //for allowing save
    @Binding var cannotSave: Bool
    
    //acts as delegate for PickerVC
    //talks between UIkit and SwiftUI
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        //didFinishPicking called automatically by iOS when image is selected
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    //type case here bc image can be any data type
                    self.parent.image = image as? UIImage
                    self.parent.cannotSave = false
                }
            }
        }
    
    }
    //understnd how to make a view controller to return a PHPickerVC
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        //all functionality of selecting an image
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

