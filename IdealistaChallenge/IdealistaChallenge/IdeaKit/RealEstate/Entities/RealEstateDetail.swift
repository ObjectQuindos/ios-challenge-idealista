//
//  RealStateDetail.swift
//  IdealistaChallenge
//

import Foundation

struct RealEstateDetail: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfoDetail
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: Multimedia
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification
}
