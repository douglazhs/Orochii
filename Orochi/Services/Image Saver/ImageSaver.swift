//
//  ImageSaver.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/07/23.
//

import Foundation
import UIKit
import Kingfisher

/// Chapter Image saver
final class ImageSaver: NSObject {
    /// Get the image from Kingfisher cache and save on gallery
    /// - Parameter image: Cached Image key
    func writeToPhotoAlbum(_ image: String) {
        KingfisherManager.shared
            .cache
            .retrieveImage(forKey: image) { result in
                switch result {
                case.success(let value):
                    if value.cacheType != .none {
                        if let cgImage = value.image?.cgImage {
                            UIImageWriteToSavedPhotosAlbum(
                                UIImage(cgImage: cgImage),
                                #selector(self.saveCompleted),
                                nil,
                                nil
                            )
                        }
                    }
                case .failure(let error): print(error.localizedDescription)
                }
            }
    }
    
    /// Called when user try to save the image on gallery
    /// - Parameters:
    ///   - image: Image to be saved
    ///   - error: Possible error
    ///   - contextInfo: -
    @objc func saveCompleted(
        _ image: UIImage,
        didFinishSavingWithError error: Error?,
        contextInfo: UnsafeRawPointer
    ) {
        
    }
}
