//
//  DIContainer.swift
//  IdealistaChallenge
//

protocol DependencyContainer {
    
    associatedtype RealEstate: RealEstateFactoryType
    
    var realEstateFactory: RealEstate { get }
}

final class AppDependencyContainer: DependencyContainer {
    
    let realEstateFactory: RealEstateFactory
    
    init() {
        self.realEstateFactory = RealEstateFactory()
    }
}
