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
    
    func removeFavorite(realEstate: RealEstate) async throws {
        repository.delete(realEstate: realEstate)
        
    }
    
    func toogleFavorite(for realEstate: RealEstate) -> RealEstate {
        repository.toggleFavorite(for: realEstate)
    }
    
    func isRealEstateFavorite(propertyCode: String) -> Bool {
        repository.isRealEstateFavorite(propertyCode: propertyCode)
    }
}
