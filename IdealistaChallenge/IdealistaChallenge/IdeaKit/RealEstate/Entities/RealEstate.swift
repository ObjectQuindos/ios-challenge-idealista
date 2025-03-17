//
//  Models.swift
//  IdealistaChallenge
//

import Foundation

struct RealEstate: Codable, Identifiable {
    
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features
    let parkingSpace: ParkingSpace?
    
    var createdAt: Date? = Date()
    var isFavorite: Bool? = false
    
    var id: String {
        return propertyCode
    }
}
