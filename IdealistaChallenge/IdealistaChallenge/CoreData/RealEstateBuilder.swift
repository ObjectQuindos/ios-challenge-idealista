//
//  RealEstateBuilder.swift
//  IdealistaChallenge
//

import Foundation

class RealEstateBuilder {
    
    private var propertyCode: String
    private var thumbnail: String = ""
    private var floor: String = ""
    private var price: Double = 0.0
    private var priceInfo: PriceInfo?
    private var propertyType: String = ""
    private var operation: String = ""
    private var size: Double = 0.0
    private var exterior: Bool = false
    private var rooms: Int = 0
    private var bathrooms: Int = 0
    private var address: String = ""
    private var province: String = ""
    private var municipality: String = ""
    private var district: String = ""
    private var country: String = ""
    private var neighborhood: String = ""
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var description: String = ""
    private var multimedia: Multimedia = Multimedia(images: [])
    private var features: Features = Features()
    private var parkingSpace: ParkingSpace?
    private var isFavorite: Bool = false
    
    init(propertyCode: String) {
        self.propertyCode = propertyCode
    }
    
    func withThumbnail(_ thumbnail: String) -> RealEstateBuilder {
        self.thumbnail = thumbnail
        return self
    }
    
    func withFloor(_ floor: String) -> RealEstateBuilder {
        self.floor = floor
        return self
    }
    
    func withPrice(_ price: Double) -> RealEstateBuilder {
        self.price = price
        return self
    }
    
    func withPriceInfo(_ priceInfo: PriceInfo) -> RealEstateBuilder {
        self.priceInfo = priceInfo
        return self
    }
    
    func withPropertyType(_ propertyType: String) -> RealEstateBuilder {
        self.propertyType = propertyType
        return self
    }
    
    func withOperation(_ operation: String) -> RealEstateBuilder {
        self.operation = operation
        return self
    }
    
    func withSize(_ size: Double) -> RealEstateBuilder {
        self.size = size
        return self
    }
    
    func withExterior(_ exterior: Bool) -> RealEstateBuilder {
        self.exterior = exterior
        return self
    }
    
    func withRooms(_ rooms: Int) -> RealEstateBuilder {
        self.rooms = rooms
        return self
    }
    
    func withBathrooms(_ bathrooms: Int) -> RealEstateBuilder {
        self.bathrooms = bathrooms
        return self
    }
    
    func withAddress(_ address: String) -> RealEstateBuilder {
        self.address = address
        return self
    }
    
    func withProvince(_ province: String) -> RealEstateBuilder {
        self.province = province
        return self
    }
    
    func withMunicipality(_ municipality: String) -> RealEstateBuilder {
        self.municipality = municipality
        return self
    }
    
    func withDistrict(_ district: String) -> RealEstateBuilder {
        self.district = district
        return self
    }
    
    func withCountry(_ country: String) -> RealEstateBuilder {
        self.country = country
        return self
    }
    
    func withNeighborhood(_ neighborhood: String) -> RealEstateBuilder {
        self.neighborhood = neighborhood
        return self
    }
    
    func withCoordinates(latitude: Double, longitude: Double) -> RealEstateBuilder {
        self.latitude = latitude
        self.longitude = longitude
        return self
    }
    
    func withDescription(_ description: String) -> RealEstateBuilder {
        self.description = description
        return self
    }
    
    func withMultimedia(_ multimedia: Multimedia) -> RealEstateBuilder {
        self.multimedia = multimedia
        return self
    }
    
    func withFeatures(_ features: Features) -> RealEstateBuilder {
        self.features = features
        return self
    }
    
    func withParkingSpace(_ parkingSpace: ParkingSpace?) -> RealEstateBuilder {
        self.parkingSpace = parkingSpace
        return self
    }
    
    func withFavorite(_ isFavorite: Bool) -> RealEstateBuilder {
        self.isFavorite = isFavorite
        return self
    }
    
    func build() -> RealEstate {
        
        // Si no se especificó PriceInfo, crear uno por defecto
        let finalPriceInfo = priceInfo ?? PriceInfo(price: PriceDetails(amount: price, currencySuffix: "€"))
        
        return RealEstate(
            propertyCode: propertyCode,
            thumbnail: thumbnail,
            floor: floor,
            price: price,
            priceInfo: finalPriceInfo,
            propertyType: propertyType,
            operation: operation,
            size: size,
            exterior: exterior,
            rooms: rooms,
            bathrooms: bathrooms,
            address: address,
            province: province,
            municipality: municipality,
            district: district,
            country: country,
            neighborhood: neighborhood,
            latitude: latitude,
            longitude: longitude,
            description: description,
            multimedia: multimedia,
            features: features,
            parkingSpace: parkingSpace,
            isFavorite: isFavorite
        )
    }
    
    static func from(realEstate: RealEstate) -> RealEstateBuilder {
        
        let builder = RealEstateBuilder(propertyCode: realEstate.propertyCode)
            .withThumbnail(realEstate.thumbnail)
            .withFloor(realEstate.floor)
            .withPrice(realEstate.price)
            .withPriceInfo(realEstate.priceInfo)
            .withPropertyType(realEstate.propertyType)
            .withOperation(realEstate.operation)
            .withSize(realEstate.size)
            .withExterior(realEstate.exterior)
            .withRooms(realEstate.rooms)
            .withBathrooms(realEstate.bathrooms)
            .withAddress(realEstate.address)
            .withProvince(realEstate.province)
            .withMunicipality(realEstate.municipality)
            .withDistrict(realEstate.district)
            .withCountry(realEstate.country)
            .withNeighborhood(realEstate.neighborhood)
            .withCoordinates(latitude: realEstate.latitude, longitude: realEstate.longitude)
            .withDescription(realEstate.description)
            .withMultimedia(realEstate.multimedia)
            .withFeatures(realEstate.features)
            .withFavorite(realEstate.isFavorite ?? false)
            .withParkingSpace(realEstate.parkingSpace)
        
        return builder
    }
    
    static func toggleFavorite(realEstate: RealEstate) -> RealEstate {
        return RealEstateBuilder.from(realEstate: realEstate)
            .withFavorite(!(realEstate.isFavorite ?? false))
            .build()
    }
}
