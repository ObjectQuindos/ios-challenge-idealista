//
//  RealEstateEntityMapper.swift
//  IdealistaChallenge
//

import Foundation
import CoreData

protocol EntityMapper {
    
    associatedtype DomainType
    associatedtype EntityType
    
    func mapToDomain(entity: EntityType) -> DomainType?
    func mapToEntity(domain: DomainType, in context: NSManagedObjectContext) -> EntityType
}

class RealEstateEntityMapper {
    
    func mapToDomain(entity: RealEstateEntity) -> RealEstate? {
        guard let propertyCode = entity.propertyCode else { return nil }
        
        let priceInfo = mapPriceInfoFromEntity(entity)
        let multimedia = mapMultimediaFromEntity(entity)
        let features = mapFeaturesFromEntity(entity)
        let parkingSpace = mapParkingSpaceFromEntity(entity)
        
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
            multimedia: multimedia,
            features: features,
            parkingSpace: parkingSpace,
            isFavorite: entity.isFavorite
        )
    }
    
    func mapToEntity(domain: RealEstate, in context: NSManagedObjectContext) -> RealEstateEntity {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", domain.propertyCode)
        
        let entity: RealEstateEntity
        
        do {
            if let existingEntity = try context.fetch(fetchRequest).first {
                entity = existingEntity
                
            } else {
                entity = RealEstateEntity(context: context)
            }
            
        } catch {
            print("Error al buscar entidad existente: \(error)")
            entity = RealEstateEntity(context: context)
        }
        
        entity.propertyCode = domain.propertyCode
        entity.thumbnail = domain.thumbnail
        entity.floor = domain.floor
        entity.price = domain.price
        entity.propertyType = domain.propertyType
        entity.operation = domain.operation
        entity.size = domain.size
        entity.exterior = domain.exterior
        entity.rooms = Int16(domain.rooms)
        entity.bathrooms = Int16(domain.bathrooms)
        entity.address = domain.address
        entity.province = domain.province
        entity.municipality = domain.municipality
        entity.district = domain.district
        entity.country = domain.country
        entity.neighborhood = domain.neighborhood
        entity.latitude = domain.latitude
        entity.longitude = domain.longitude
        entity.descriptionText = domain.description
        entity.isFavorite = domain.isFavorite ?? false
        
        configurePriceInfoEntity(for: entity, with: domain.priceInfo, in: context)
        configureMultimediaEntity(for: entity, with: domain.multimedia, in: context)
        configureFeaturesEntity(for: entity, with: domain.features, in: context)
        
        if let parkingSpace = domain.parkingSpace {
            configureParkingSpaceEntity(for: entity, with: parkingSpace, in: context)
            
        } else if entity.parkingSpace != nil {
            context.delete(entity.parkingSpace!)
            entity.parkingSpace = nil
        }
        
        return entity
    }
    
    // MARK: - Métodos privados para mapeo de entidades
    
    private func mapPriceInfoFromEntity(_ entity: RealEstateEntity) -> PriceInfo {
        
        if let priceInfoEntity = entity.priceInfo, let priceDetailsEntity = priceInfoEntity.price {
            
            let priceDetails = PriceDetails(
                amount: priceDetailsEntity.amount,
                currencySuffix: priceDetailsEntity.currencySuffix ?? ""
            )
            return PriceInfo(price: priceDetails)
            
        } else {
            
            let defaultPriceDetails = PriceDetails(amount: entity.price, currencySuffix: "€")
            return PriceInfo(price: defaultPriceDetails)
        }
    }
    
    private func mapMultimediaFromEntity(_ entity: RealEstateEntity) -> Multimedia {
        var images: [ImageData] = []
        
        if let multimediaEntity = entity.multimedia?.images?.allObjects as? [ImageDataEntity] {
            images = multimediaEntity.compactMap { imageEntity in
                ImageData(
                    url: imageEntity.url ?? "",
                    tag: imageEntity.tag ?? "",
                    localizedName: imageEntity.localizedName,
                    multimediaId: Int(imageEntity.multimediaId)
                )
            }
        }
        
        return Multimedia(images: images)
    }
    
    private func mapFeaturesFromEntity(_ entity: RealEstateEntity) -> Features {
        
        if let featuresEntity = entity.features {
            
            return Features(
                has_air_conditioning: featuresEntity.hasAirConditioning,
                has_box_room: featuresEntity.hasBoxRoom,
                has_swimming_pool: featuresEntity.hasSwimmingPool,
                has_terrace: featuresEntity.hasTerrace,
                has_garden: featuresEntity.hasGarden
            )
        }
        
        return Features()
    }
    
    private func mapParkingSpaceFromEntity(_ entity: RealEstateEntity) -> ParkingSpace? {
        
        if let parkingEntity = entity.parkingSpace {
            
            return ParkingSpace(
                hasParkingSpace: parkingEntity.hasParkingSpace,
                isParkingSpaceIncludedInPrice: parkingEntity.isParkingSpaceIncludedInPrice
            )
        }
        
        return nil
    }
    
    // MARK: - Métodos privados para configuración de entidades relacionadas
    
    private func configurePriceInfoEntity(for entity: RealEstateEntity, with priceInfo: PriceInfo, in context: NSManagedObjectContext) {
        
        let priceInfoEntity = entity.priceInfo ?? PriceInfoEntity(context: context)
        let priceDetailsEntity = priceInfoEntity.price ?? PriceDetailsEntity(context: context)
        
        priceDetailsEntity.amount = priceInfo.price.amount
        priceDetailsEntity.currencySuffix = priceInfo.price.currencySuffix
        
        priceInfoEntity.price = priceDetailsEntity
        entity.priceInfo = priceInfoEntity
    }
    
    private func configureMultimediaEntity(for entity: RealEstateEntity, with multimedia: Multimedia, in context: NSManagedObjectContext) {
        let multimediaEntity = entity.multimedia ?? MultimediaEntity(context: context)
        
        // Eliminar imágenes existentes
        if let existingImages = multimediaEntity.images as? Set<ImageDataEntity> {
            for imageEntity in existingImages {
                context.delete(imageEntity)
            }
        }
        
        // Crear nuevas imágenes
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
    
    private func configureFeaturesEntity(for entity: RealEstateEntity, with features: Features, in context: NSManagedObjectContext) {
        
        let featuresEntity = entity.features ?? FeaturesEntity(context: context)
        
        featuresEntity.hasAirConditioning = features.hasAirConditioning
        featuresEntity.hasBoxRoom = features.hasBoxRoom
        featuresEntity.hasGarden = features.hasGarden
        featuresEntity.hasSwimmingPool = features.hasSwimmingPool
        featuresEntity.hasTerrace = features.hasTerrace
        
        entity.features = featuresEntity
    }
    
    private func configureParkingSpaceEntity(for entity: RealEstateEntity, with parkingSpace: ParkingSpace, in context: NSManagedObjectContext) {
        
        let parkingSpaceEntity = entity.parkingSpace ?? ParkingSpaceEntity(context: context)
        
        parkingSpaceEntity.hasParkingSpace = parkingSpace.hasParkingSpace
        parkingSpaceEntity.isParkingSpaceIncludedInPrice = parkingSpace.isParkingSpaceIncludedInPrice
        
        entity.parkingSpace = parkingSpaceEntity
    }
}
