//
//  FavoritesInteractor.swift
//  IdealistaChallenge
//

import Foundation

class FavoritesInteractor {
    
    private let repository: RealEstateRepository
    
    init(repository: RealEstateRepository) {
        self.repository = repository
    }
    
    func listFavorites() throws -> [RealEstate] {
        let favorites = repository.getAllRealEstates()
        return favorites
    }
    
    func removeFavorite(realEstate: RealEstate) throws {
        repository.delete(realEstate: realEstate)
        
    }
    
    func toogleFavorite(for realEstate: RealEstate) -> RealEstate {
        repository.toggleFavorite(for: realEstate)
    }
    
    func isRealEstateFavorite(propertyCode: String) -> Bool {
        repository.isRealEstateFavorite(propertyCode: propertyCode)
    }
    
    func syncFavoriteStatus(realEstate: RealEstate) -> RealEstate {
        
        let favorites = try? listFavorites()
        
        if let favorites = favorites, let favorite = favorites.first(where: { $0.propertyCode == realEstate.propertyCode }) {
            
            // it is in favourites
            var updatedRealEstate = realEstate
            updatedRealEstate.isFavorite = true
            updatedRealEstate.createdAt = favorite.createdAt
            return updatedRealEstate
            
        } else {
            
            // not in favourites
            var updatedRealEstate = realEstate
            updatedRealEstate.isFavorite = false
            updatedRealEstate.createdAt = nil
            return updatedRealEstate
        }
    }
    
    // sync list of properties
    func syncFavoriteStatus(realEstates: [RealEstate]) -> [RealEstate] {
        return realEstates.map { syncFavoriteStatus(realEstate: $0) }
    }
}
