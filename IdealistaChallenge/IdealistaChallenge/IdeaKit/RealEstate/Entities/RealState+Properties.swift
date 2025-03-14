//
//  RealState+Properties.swift
//  IdealistaChallenge
//

import Foundation

struct PriceInfo: Codable {
    let price: PriceDetails
}

struct PriceDetails: Codable {
    let amount: Double
    let currencySuffix: String
}

struct Multimedia: Codable {
    let images: [Image]
}

struct Image: Codable, Identifiable {
    
    let url: String
    let tag: String
    
    let localizedName: String?
    let multimediaId: Int?
    
    var id: String {
        return url
    }
}

struct ParkingSpace: Codable {
    let hasParkingSpace: Bool
    let isParkingSpaceIncludedInPrice: Bool
}

struct Features: Codable {
    
    private let has_air_conditioning: Bool?
    private let has_box_room: Bool?
    private let has_swimming_pool: Bool?
    private let has_terrace: Bool?
    private let has_garden: Bool?
    
    enum CodingKeys: String, CodingKey {
        case has_air_conditioning = "hasAirConditioning"
        case has_box_room = "hasBoxRoom"
        case has_swimming_pool = "hasSwimmingPool"
        case has_terrace = "hasTerrace"
        case has_garden = "hasGarden"
    }
    
    var hasAirConditioning: Bool {
        return has_air_conditioning ?? false
    }
    
    var hasBoxRoom: Bool {
        return has_box_room ?? false
    }
    
    var hasSwimmingPool: Bool {
        return has_swimming_pool ?? false
    }
    
    var hasTerrace: Bool {
        return has_terrace ?? false
    }
    
    var hasGarden: Bool {
        return has_garden ?? false
    }
}
