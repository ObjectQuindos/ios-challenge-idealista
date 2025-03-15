//
//  Untitled.swift
//  IdealistaChallenge
//

import Foundation

protocol RealEstateDetailFactoryType {
    func makeModule(coordinator: Coordinator) -> RealEstateDetailView
}

final class RealEstateDetailFactory: RealEstateDetailFactoryType {
    
    func makeModule(coordinator: Coordinator) -> RealEstateDetailView {
        
        let interactor = RealEStateInteractor()
        let viewModel = RealEstateDetailViewModel(interactor: interactor, coordinator: coordinator)
        
        return RealEstateDetailView(viewModel: viewModel)
    }
}
