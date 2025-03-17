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
        
        // La configuración del botón de favoritos debe ser implementada por cada subclase
        configureFavoriteAction(for: item, in: cell)
    }
    
    func configureImage(for item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        
        if let firstImageUrl = item.multimedia.images.first?.url {
            
            if let cachedImage = imageManager.getCachedImage(for: firstImageUrl) {
                cell.setImage(cachedImage)
                
            } else {
                cell.setImage(UIImage(systemName: "photo"))
                imageManager.downloadImage(from: firstImageUrl) { image in
                    cell.setImage(image)
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
}
