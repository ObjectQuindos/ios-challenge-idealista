//
//  DIContainer.swift
//  IdealistaChallenge
//

protocol DependencyContainer {
    
    associatedtype RealEstate: RealEstateFactoryType
    associatedtype RealEstateDetail: RealEstateDetailFactoryType
    
    var realEstateFactory: RealEstate { get }
    var realEstateDetailFactory: RealEstateDetail { get }
}

final class AppDependencyContainer: DependencyContainer {
    
    var realEstateFactory: RealEstateFactory {
        return RealEstateFactory()
    }
    
    var realEstateDetailFactory: RealEstateDetailFactory {
        return RealEstateDetailFactory()
    }
}
