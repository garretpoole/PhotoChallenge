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
    
    func writeToPhotoAlbum(image: UIImage) {
        
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
