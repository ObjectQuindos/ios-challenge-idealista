//
//  DIContainer.swift
//  IdealistaChallenge
//

protocol DependencyContainer {
    
    associatedtype RealEstate: RealEstateFactoryType
    associatedtype RealEstateDetail: RealEstateDetailFactoryType
    associatedtype Favorites: FavoritesFactoryType
    
    var realEstateFactory: RealEstate { get }
    var realEstateDetailFactory: RealEstateDetail { get }
    var favoritesFactory: Favorites { get }
}

final class AppDependencyContainer: DependencyContainer {
    
    let imageManager: ImageManaging = ImageManager()
    
    var realEstateFactory: RealEstateFactory {
        return RealEstateFactory()
    }
    
    var realEstateDetailFactory: RealEstateDetailFactory {
        return RealEstateDetailFactory()
    }
    
    var favoritesFactory: FavoritesFactory {
        return FavoritesFactory()
    }
}
