//
//  ImageManager.swift
//  IdealistaChallenge
//

import UIKit

protocol ImageManaging {
    func preloadImages(for items: [RealEstate])
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
    func getCachedImage(for urlString: String) -> UIImage?
}

class ImageManager: ImageManaging {
    
    private var imageCache: [String: UIImage] = [:]
    
    func preloadImages(for items: [RealEstate]) {
        
        for item in items {
            
            if let firstImageUrl = item.multimedia.images.first?.url {
                downloadImage(from: firstImageUrl) { _ in }
            }
        }
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        ImageDownloader.shared.downloadImage(from: urlString) { [weak self] image in
            
            guard let self = self, let image = image else {
                completion(nil)
                return
            }
            
            self.imageCache[urlString] = image
            completion(image)
        }
    }
    
    func getCachedImage(for urlString: String) -> UIImage? {
        return imageCache[urlString]
    }
}
