//
//  ImageSaverInAlbum.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import UIKit

class ImageSaverInAlbum: NSObject {
    func addInPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletionHandler), nil)
    }
    
    @objc
    private func saveCompletionHandler(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved in album")
    }
}
