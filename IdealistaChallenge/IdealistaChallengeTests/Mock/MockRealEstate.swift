//
//  Mocks.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import Foundation
@testable import IdealistaChallenge

extension RealEstate {
    
    static let getMockRealEstates: [RealEstate] = [realEstate1, realEstate2, realEstate3]
    
    static let realEstate1 = RealEstate(
        propertyCode: "property001",
        thumbnail: "https://example.com/thumbnail1.jpg",
        floor: "2º",
        price: 250000.0,
        priceInfo: PriceInfo(price: PriceDetails(amount: 250000.0, currencySuffix: "€")),
        propertyType: "Piso",
        operation: "Venta",
        size: 85.5,
        exterior: true,
        rooms: 3,
        bathrooms: 2,
        address: "Calle Mayor, 10",
        province: "Madrid",
        municipality: "Madrid",
        district: "Centro",
        country: "España",
        neighborhood: "Sol",
        latitude: 40.416775,
        longitude: -3.703790,
        description: "Luminoso piso en el centro de Madrid con excelentes vistas",
        multimedia: Multimedia(images: [
            ImageData(url: "https://example.com/image1.jpg", tag: "main", localizedName: "Salón", multimediaId: 1),
            ImageData(url: "https://example.com/image2.jpg", tag: "room", localizedName: "Dormitorio", multimediaId: 2)
        ]),
        features: Features(has_air_conditioning: true, has_box_room: false, has_swimming_pool: false, has_terrace: true, has_garden: false),
        parkingSpace: ParkingSpace(hasParkingSpace: true, isParkingSpaceIncludedInPrice: true)
    )
    
    static let realEstate2 = RealEstate(
        propertyCode: "property002",
        thumbnail: "https://example.com/thumbnail2.jpg",
        floor: "Bajo",
        price: 180000.0,
        priceInfo: PriceInfo(price: PriceDetails(amount: 180000.0, currencySuffix: "€")),
        propertyType: "Apartamento",
        operation: "Venta",
        size: 65.0,
        exterior: false,
        rooms: 2,
        bathrooms: 1,
        address: "Calle Serrano, 25",
        province: "Madrid",
        municipality: "Madrid",
        district: "Salamanca",
        country: "España",
        neighborhood: "Recoletos",
        latitude: 40.423852,
        longitude: -3.688344,
        description: "Acogedor apartamento en el barrio de Salamanca, recientemente reformado",
        multimedia: Multimedia(images: [
            ImageData(url: "https://example.com/image3.jpg", tag: "main", localizedName: "Salón", multimediaId: 3),
            ImageData(url: "https://example.com/image4.jpg", tag: "kitchen", localizedName: "Cocina", multimediaId: 4)
        ]),
        features: Features(has_air_conditioning: true, has_box_room: true, has_swimming_pool: false, has_terrace: false, has_garden: false),
        parkingSpace: nil
    )
    
    static let realEstate3 = RealEstate(
        propertyCode: "property003",
        thumbnail: "https://example.com/thumbnail3.jpg",
        floor: "5º",
        price: 350000,
        priceInfo: PriceInfo(price: PriceDetails(amount: 350000.0, currencySuffix: "€")),
        propertyType: "Ático",
        operation: "Venta",
        size: 120.0,
        exterior: true,
        rooms: 4,
        bathrooms: 2,
        address: "Paseo de la Castellana, 100",
        province: "Madrid",
        municipality: "Madrid",
        district: "Chamartín",
        country: "España",
        neighborhood: "Hispanoamérica",
        latitude: 40.446846,
        longitude: -3.691944,
        description: "Espectacular ático con terraza, vistas panorámicas y plaza de garaje incluida",
        multimedia: Multimedia(images: [
            ImageData(url: "https://example.com/image5.jpg", tag: "main", localizedName: "Salón", multimediaId: 5),
            ImageData(url: "https://example.com/image6.jpg", tag: "terrace", localizedName: "Terraza", multimediaId: 6)
        ]),
        features: Features(has_air_conditioning: true, has_box_room: true, has_swimming_pool: true, has_terrace: true, has_garden: false),
        parkingSpace: ParkingSpace(hasParkingSpace: true, isParkingSpaceIncludedInPrice: false)
    )
}

extension RealEstateDetail {
    
    static let getMockRealEstateDetails: [RealEstateDetail] = [realEstateDetail1, realEstateDetail2]
    
    static let realEstateDetail1 = RealEstateDetail(
        adid: 123456,
        price: 250000.0,
        priceInfo: PriceInfoDetail(
            amount: 250000.0,
            currencySuffix: "€"
        ),
        operation: "Venta",
        propertyType: "Piso",
        extendedPropertyType: "Vivienda",
        homeType: "Piso",
        state: "Buen estado",
        multimedia: Multimedia(images: [
            ImageData(url: "https://example.com/image1.jpg", tag: "main", localizedName: "Salón", multimediaId: 1),
            ImageData(url: "https://example.com/image2.jpg", tag: "room", localizedName: "Dormitorio", multimediaId: 2),
            ImageData(url: "https://example.com/image3.jpg", tag: "bathroom", localizedName: "Baño", multimediaId: 3)
        ]),
        propertyComment: "Luminoso piso en el centro de Madrid con excelentes vistas. Dispone de tres habitaciones, dos baños completos, cocina equipada y un amplio salón-comedor. El edificio cuenta con ascensor y servicio de portería. Muy bien comunicado, a pocos metros del transporte público y todos los servicios necesarios para su comodidad.",
        ubication: Ubication(
            latitude: 40.416775,
            longitude: -3.703790
        ),
        country: "España",
        moreCharacteristics: MoreCharacteristics(
            communityCosts: 85.0,
            roomNumber: 3,
            bathNumber: 2,
            exterior: true,
            housingFurnitures: "Sin amueblar",
            agencyIsABank: false,
            energyCertificationType: "Obtenido",
            flatLocation: "Exterior",
            modificationDate: 1721083200, // 16/07/2024
            constructedArea: 90,
            lift: true,
            boxroom: false,
            isDuplex: false,
            floor: "2º",
            status: "Buen estado"
        ),
        energyCertification: EnergyCertification(
            title: "Certificación energética",
            energyConsumption: EnergyInfo(type: "C"),
            emissions: EnergyInfo(type: "D")
        )
    )
    
    static let realEstateDetail2 = RealEstateDetail(
        adid: 789012,
        price: 180000.0,
        priceInfo: PriceInfoDetail(
            amount: 180000.0,
            currencySuffix: "€"
        ),
        operation: "Venta",
        propertyType: "Apartamento",
        extendedPropertyType: "Vivienda",
        homeType: "Apartamento",
        state: "Reformado",
        multimedia: Multimedia(images: [
            ImageData(url: "https://example.com/image4.jpg", tag: "main", localizedName: "Salón", multimediaId: 4),
            ImageData(url: "https://example.com/image5.jpg", tag: "kitchen", localizedName: "Cocina", multimediaId: 5)
        ]),
        propertyComment: "Acogedor apartamento en el barrio de Salamanca, recientemente reformado. Consta de dos habitaciones, un baño, cocina americana y salón. El inmueble dispone de aire acondicionado, calefacción central y suelos de parquet. Ubicación inmejorable, rodeado de comercios, restaurantes y zonas verdes.",
        ubication: Ubication(
            latitude: 40.423852,
            longitude: -3.688344
        ),
        country: "España",
        moreCharacteristics: MoreCharacteristics(
            communityCosts: 65.0,
            roomNumber: 2,
            bathNumber: 1,
            exterior: false,
            housingFurnitures: "Sin amueblar",
            agencyIsABank: false,
            energyCertificationType: "Obtenido",
            flatLocation: "Interior",
            modificationDate: 1721169600, // 17/07/2024
            constructedArea: 65,
            lift: true,
            boxroom: true,
            isDuplex: false,
            floor: "Bajo",
            status: "Reformado"
        ),
        energyCertification: EnergyCertification(
            title: "Certificación energética",
            energyConsumption: EnergyInfo(type: "B"),
            emissions: EnergyInfo(type: "C")
        )
    )
}

struct Converter {
    
    private static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }
    
    static func convertRealEstateToData(_ realEstate: RealEstate) -> Data? {
        
        do {
            let data = try Converter.encoder.encode(realEstate)
            return data
            
        } catch {
            print("Error al codificar RealEstate: \(error)")
            return nil
        }
    }
    
    static func convertRealEstateDetailToData(_ realEstateDetail: RealEstateDetail) -> Data? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        do {
            let data = try Converter.encoder.encode(realEstateDetail)
            return data
            
        } catch {
            print("Error al codificar RealEstateDetail: \(error)")
            return nil
        }
    }
}
