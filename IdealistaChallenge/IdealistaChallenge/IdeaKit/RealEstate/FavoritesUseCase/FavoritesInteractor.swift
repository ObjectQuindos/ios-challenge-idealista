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
        
        let isFavorite = isRealEstateFavorite(propertyCode: realEstate.propertyCode)
        
        // Si el estado actual es diferente del que está en el modelo
        if isFavorite != (realEstate.isFavorite ?? false) {
            return RealEstateBuilder.from(realEstate: realEstate)
                .withFavorite(isFavorite)
                .build()
        }
        
        return realEstate
    }
    
    // Método para sincronizar una lista de propiedades
    func syncFavoriteStatus(realEstates: [RealEstate]) -> [RealEstate] {
        return realEstates.map { syncFavoriteStatus(realEstate: $0) }
    }
}
