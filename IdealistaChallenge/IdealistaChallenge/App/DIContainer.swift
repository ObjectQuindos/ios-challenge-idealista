//
//  DIContainer.swift
//  IdealistaChallenge
//

protocol iPadFactoryType {}
final class iPadFactory: iPadFactoryType {}

protocol DependencyContainer {
    
    associatedtype RealEstate: RealEstateFactoryType
    associatedtype RealEstateDetail: RealEstateDetailFactoryType
    associatedtype Favorites: FavoritesFactoryType
    associatedtype iPadLayout: iPadFactoryType
    
    var realEstateFactory: RealEstate { get }
    var realEstateDetailFactory: RealEstateDetail { get }
    var favoritesFactory: Favorites { get }
    var iPadLayoutFactory: iPadLayout { get }
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
    
    var iPadLayoutFactory: iPadFactory {
        return iPadFactory()
    }
}
