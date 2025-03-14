//
//  RealStateDetail+Properties.swift
//  IdealistaChallenge
//

import Foundation

struct Ubication: Codable {
    let latitude: Double
    let longitude: Double
}

struct MoreCharacteristics: Codable {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: TimeInterval
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertification: Codable {
    let title: String
    let energyConsumption: EnergyInfo
    let emissions: EnergyInfo
}

struct EnergyInfo: Codable {
    let type: String
}
