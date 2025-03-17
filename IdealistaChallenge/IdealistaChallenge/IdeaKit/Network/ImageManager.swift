//
//  ImageManager.swift
//  IdealistaChallenge
//

import UIKit

protocol ImageManaging {
    func preloadImages(for items: [RealEstate])
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
    func downloadAllImages(from item: RealEstate, completion: @escaping ([String: UIImage]) -> Void)
    func getCachedImage(for urlString: String) -> UIImage?
    func getCachedImages(for urlStrings: [String]) -> [String : UIImage]
    func getAllCachedImages() -> [String : UIImage]
}

class ImageManager: ImageManaging {
    
    private var imageCache: [String : UIImage] = [:]
    private let downloadQueue = DispatchQueue(label: "imageDownload", attributes: .concurrent)
    
    func preloadImages(for items: [RealEstate]) {
        
        for item in items {
            
            for imageData in item.multimedia.images {
                
                let urlString = imageData.url
                
                if getCachedImage(for: urlString) == nil {
                    downloadImage(from: imageData.url) { _ in }
                }
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
    
    func downloadAllImages(from item: RealEstate, completion: @escaping ([String : UIImage]) -> Void) {
        
        let imageUrls = item.multimedia.images.map { $0.url }
        if imageUrls.isEmpty {
            completion([:])
            return
        }
        
        // in cache?
        var imagesResult = getCachedImages(for: imageUrls)
        
        // urls to download
        let urlsToDownload = imageUrls.filter { !imagesResult.keys.contains($0) }
        
        // If all images in cache, return with the result
        if urlsToDownload.isEmpty {
            completion(imagesResult)
            return
        }
        
        let group = DispatchGroup()
        let lock = NSLock()
        
        for urlString in urlsToDownload {
            group.enter()
            downloadQueue.async {
                self.downloadImage(from: urlString) { image in
                    if let image = image {
                        lock.lock()
                        imagesResult[urlString] = image
                        lock.unlock()
                    }
                    group.leave()
                }
            }
        }
            
        group.notify(queue: .main) {
            completion(imagesResult)
        }
    }
    
    func getCachedImage(for urlString: String) -> UIImage? {
        return imageCache[urlString]
    }
    
    func getCachedImages(for urlStrings: [String]) -> [String: UIImage] {
        var results: [String: UIImage] = [:]
        
        for urlString in urlStrings {
            if let image = getCachedImage(for: urlString) {
                results[urlString] = image
            }
        }
        
        return results
    }
    
    func getAllCachedImages() -> [String : UIImage] {
        imageCache
    }
}
