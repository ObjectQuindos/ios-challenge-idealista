//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 16/3/25.
//

import UIKit

class RealEstateBasePresenter: RealEstateAdapterDelegate {
    
    let imageManager: ImageManaging
    
    init(imageManager: ImageManaging = ImageManager()) {
        self.imageManager = imageManager
    }
    
    func numberOfRows() -> Int {
        fatalError("Debe ser implementado por la subclase")
    }
    
    func item(at index: Int) -> RealEstate {
        fatalError("Debe ser implementado por la subclase")
    }
    
    func didSelectedItem(at index: Int) {
        fatalError("Debe ser implementado por la subclase")
    }
    
    func present(item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        
        cell.configureTexts(realEstate: item)
        cell.configureFavoriteButton(isFavorite: item.isFavorite ?? false)
        
        configureImage(for: item, in: cell)
        
        // configuration implemented by subclass
        configureFavoriteAction(for: item, in: cell)
    }
    
    func configureImage(for item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        
        if let firstImageUrl = item.multimedia.images.first?.url {
            
            if let cachedImage = imageManager.getCachedImage(for: firstImageUrl) {
                cell.setImage(cachedImage)
                
                // Remaining images and save in cache
                if item.multimedia.images.count > 1 {
                    downloadRemainingImages(for: item)
                }
            } else {
                cell.setImage(UIImage(systemName: "photo"))
                
                // Download all images
                imageManager.downloadAllImages(from: item) { images in
                    
                    if let firstImage = images[firstImageUrl] {
                        cell.setImage(firstImage)
                    }
                }
            }
            
        } else {
            cell.setImage(nil)
        }
    }
    
    func configureFavoriteAction(for item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        fatalError("Debe ser implementado por la subclase")
    }
    
    func findIndex(for propertyCode: String, in dataSource: [RealEstate]) -> Int? {
        return dataSource.firstIndex(where: { $0.propertyCode == propertyCode })
    }
    
    private func downloadRemainingImages(for item: RealEstate) {
        
        // Do not need the first one already downloaded
        let remainingUrls = Array(item.multimedia.images.dropFirst()).map { $0.url }
        
        for urlString in remainingUrls {
            
            if imageManager.getCachedImage(for: urlString) == nil {
                imageManager.downloadImage(from: urlString) { _ in }
            }
        }
    }
}
