//
//  RealEstateFactory.swift
//  IdealistaChallenge
//

import UIKit

protocol RealEstateFactoryType {
    func makeModule(coordinator: Coordinator) -> RealEstateViewController
}

final class RealEstateFactory: RealEstateFactoryType {
    
    func makeModule(coordinator: Coordinator) -> RealEstateViewController {
        
        let interactor = RealEStateInteractor()
        let repository = FavoritesRealEstateRepository()
        let favoritesInteractor = FavoritesInteractor(repository: repository)
        let presenter = RealEstateListPresenter(interactor: interactor, favoritesInteractor: favoritesInteractor, coordinator: coordinator)
        
        return RealEstateViewController(presenter: presenter)
    }
}
