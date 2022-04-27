//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Garret Poole on 4/14/22.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToSecureDirectory(uiImage: UIImage, id: String) {
        do{
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                let url = FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
                try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                print("Sucessful write to directory")
            }
        } catch {
            print("Failed to write to directory")
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //report cleanly what worked
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
