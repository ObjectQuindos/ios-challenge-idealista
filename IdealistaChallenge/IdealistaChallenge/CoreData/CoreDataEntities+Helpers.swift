//
//  CoreDataEntities+Helpers.swift
//  IdealistaChallenge
//

import Foundation
import CoreData

extension FavoritesRealEstateRepository {
    
    func convertToRealEstate(_ entity: RealEstateEntity) -> RealEstate? {
        
        guard let propertyCode = entity.propertyCode else { return nil }
        
        var priceInfo: PriceInfo
        
        if let priceInfoEntity = entity.priceInfo, let priceDetailsEntity = priceInfoEntity.price {
            
            let priceDetails = PriceDetails(amount: priceDetailsEntity.amount, currencySuffix: priceDetailsEntity.currencySuffix ?? "")
            priceInfo = PriceInfo(price: priceDetails)
            
        } else {
            // Crear un PriceInfo por defecto si no existe
            let defaultPriceDetails = PriceDetails(amount: entity.price, currencySuffix: "€")
            priceInfo = PriceInfo(price: defaultPriceDetails)
        }
        
        var multimediaObj = Multimedia(images: [])
        if let multimediaEntity = entity.multimedia?.images?.allObjects as? [ImageDataEntity] {
            
            let images: [ImageData] = multimediaEntity.compactMap { imageEntity in
                
                return ImageData(
                    url: imageEntity.url ?? "",
                    tag: imageEntity.tag ?? "",
                    localizedName: imageEntity.localizedName,
                    multimediaId: Int(imageEntity.multimediaId)
                )
            }
            
            multimediaObj = Multimedia(images: images)
        }
        
        var featuresObj = Features()
        if let featuresEntity = entity.features {
            featuresObj = Features(has_air_conditioning: featuresEntity.hasAirConditioning, has_box_room: featuresEntity.hasBoxRoom, has_swimming_pool: featuresEntity.hasSwimmingPool, has_terrace: featuresEntity.hasTerrace, has_garden: featuresEntity.hasGarden)
        }
        
        var parkingSpaceObj: ParkingSpace = ParkingSpace()
        if let parkingEntity = entity.parkingSpace {
            parkingSpaceObj = ParkingSpace(hasParkingSpace: parkingEntity.hasParkingSpace, isParkingSpaceIncludedInPrice: parkingEntity.isParkingSpaceIncludedInPrice)
        }
        
        return RealEstate(
            propertyCode: propertyCode,
            thumbnail: entity.thumbnail ?? "",
            floor: entity.floor ?? "",
            price: entity.price,
            priceInfo: priceInfo,
            propertyType: entity.propertyType ?? "",
            operation: entity.operation ?? "",
            size: entity.size,
            exterior: entity.exterior,
            rooms: Int(entity.rooms),
            bathrooms: Int(entity.bathrooms),
            address: entity.address ?? "",
            province: entity.province ?? "",
            municipality: entity.municipality ?? "",
            district: entity.district ?? "",
            country: entity.country ?? "",
            neighborhood: entity.neighborhood ?? "",
            latitude: entity.latitude,
            longitude: entity.longitude,
            description: entity.descriptionText ?? "",
            multimedia: multimediaObj,
            features: featuresObj,
            parkingSpace: parkingSpaceObj,
            isFavorite: entity.isFavorite
        )
    }
    
    func configureRealEstateEntity(_ entity: RealEstateEntity, with model: RealEstate) {
        
        entity.propertyCode = model.propertyCode
        entity.thumbnail = model.thumbnail
        entity.floor = model.floor
        entity.price = model.price
        entity.propertyType = model.propertyType
        entity.operation = model.operation
        entity.size = model.size
        entity.exterior = model.exterior
        entity.rooms = Int16(model.rooms)
        entity.bathrooms = Int16(model.bathrooms)
        entity.address = model.address
        entity.province = model.province
        entity.municipality = model.municipality
        entity.district = model.district
        entity.country = model.country
        entity.neighborhood = model.neighborhood
        entity.latitude = model.latitude
        entity.longitude = model.longitude
        entity.descriptionText = model.description
        entity.isFavorite = model.isFavorite ?? false
        
        configurePriceInfo(for: entity, with: model.priceInfo)
        configureMultimedia(for: entity, with: model.multimedia)
        configureFeatures(for: entity, with: model.features)
        
        if let parkingSpace = model.parkingSpace {
            configureParkingSpace(for: entity, with: parkingSpace)
            
        } else if entity.parkingSpace != nil {
            // NOTE
            // if model do not have parking but the entity it has, better remove it
            coreDataStack.viewContext.delete(entity.parkingSpace!)
            entity.parkingSpace = nil
        }
    }
    
    private func configurePriceInfo(for entity: RealEstateEntity, with priceInfo: PriceInfo) {
        let context = coreDataStack.viewContext
        
        let priceInfoEntity = entity.priceInfo ?? PriceInfoEntity(context: context)
        let priceDetailsEntity = priceInfoEntity.price ?? PriceDetailsEntity(context: context)
        
        // Properties of price and currency
        priceDetailsEntity.amount = priceInfo.price.amount
        priceDetailsEntity.currencySuffix = priceInfo.price.currencySuffix
        
        // NOTE
        // Properties of price and currency is going to price and this entity is the priceInfo
        priceInfoEntity.price = priceDetailsEntity
        entity.priceInfo = priceInfoEntity
    }
    
    private func configureMultimedia(for entity: RealEstateEntity, with multimedia: Multimedia) {
        let context = coreDataStack.viewContext
        
        // Obtener o crear MultimediaEntity
        let multimediaEntity = entity.multimedia ?? MultimediaEntity(context: context)
        
        if let existingImages = multimediaEntity.images as? Set<ImageDataEntity> {
            
            for imageEntity in existingImages {
                context.delete(imageEntity)
            }
        }
        
        let imageEntities = multimedia.images.map { imageData -> ImageDataEntity in
            
            let imageEntity = ImageDataEntity(context: context)
            imageEntity.url = imageData.url
            imageEntity.tag = imageData.tag
            imageEntity.localizedName = imageData.localizedName
            
            if let multimediaId = imageData.multimediaId {
                imageEntity.multimediaId = Int64(multimediaId)
            }
            
            imageEntity.multimedia = multimediaEntity
            return imageEntity
        }
        
        multimediaEntity.images = NSSet(array: imageEntities)
        entity.multimedia = multimediaEntity
    }
    
    private func configureFeatures(for entity: RealEstateEntity, with features: Features) {
        let context = coreDataStack.viewContext
        
        let featuresEntity = entity.features ?? FeaturesEntity(context: context)
        
        featuresEntity.hasAirConditioning = features.hasAirConditioning
        featuresEntity.hasBoxRoom = features.hasBoxRoom
        featuresEntity.hasGarden = features.hasGarden
        featuresEntity.hasSwimmingPool = features.hasSwimmingPool
        featuresEntity.hasTerrace = features.hasTerrace
        
        entity.features = featuresEntity
    }
    
    private func configureParkingSpace(for entity: RealEstateEntity, with parkingSpace: ParkingSpace) {
        let context = coreDataStack.viewContext
        
        let parkingSpaceEntity = entity.parkingSpace ?? ParkingSpaceEntity(context: context)
        
        parkingSpaceEntity.hasParkingSpace = parkingSpace.hasParkingSpace
        parkingSpaceEntity.isParkingSpaceIncludedInPrice = parkingSpace.isParkingSpaceIncludedInPrice
        
        entity.parkingSpace = parkingSpaceEntity
    }
}

extension FavoritesRealEstateRepository {
    
    func createUpdatedRealEstate(from realEstate: RealEstate, isFavorite: Bool) -> RealEstate {
        
        return RealEstate(
            propertyCode: realEstate.propertyCode,
            thumbnail: realEstate.thumbnail,
            floor: realEstate.floor,
            price: realEstate.price,
            priceInfo: realEstate.priceInfo,
            propertyType: realEstate.propertyType,
            operation: realEstate.operation,
            size: realEstate.size,
            exterior: realEstate.exterior,
            rooms: realEstate.rooms,
            bathrooms: realEstate.bathrooms,
            address: realEstate.address,
            province: realEstate.province,
            municipality: realEstate.municipality,
            district: realEstate.district,
            country: realEstate.country,
            neighborhood: realEstate.neighborhood,
            latitude: realEstate.latitude,
            longitude: realEstate.longitude,
            description: realEstate.description,
            multimedia: realEstate.multimedia,
            features: realEstate.features,
            parkingSpace: realEstate.parkingSpace,
            isFavorite: isFavorite
        )
    }
}
