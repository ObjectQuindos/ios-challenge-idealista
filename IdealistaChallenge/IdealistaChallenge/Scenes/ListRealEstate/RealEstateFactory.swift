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
        let interactor = RealStateInteractor()
        let presenter = RealEstateListPresenter(interactor: interactor, coordinator: coordinator)
        
        return RealEstateViewController(presenter: presenter)
    }
}
