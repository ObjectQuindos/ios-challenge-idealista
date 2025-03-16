//
//  FavoritesFactory.swift
//  IdealistaChallenge
//

import UIKit

protocol FavoritesFactoryType {
    func makeModule(coordinator: Coordinator) -> FavoritesViewController
}

final class FavoritesFactory: FavoritesFactoryType {
    
    func makeModule(coordinator: Coordinator) -> FavoritesViewController {
        
        let repository = FavoritesRealEstateRepository()
        let interactor = FavoritesInteractor(repository: repository)
        let presenter = FavoritesPresenter(interactor: interactor, coordinator: coordinator)
        
        return FavoritesViewController(presenter: presenter)
    }
}
