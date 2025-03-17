//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import UIKit

enum PropertyFormatters {
    
    static func formatPrice(price: Double, currencySuffix: String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 0
        
        if let formattedNumber = formatter.string(from: NSNumber(value: price)) {
            return "\(formattedNumber) \(currencySuffix)"
        }
        
        return "\(price) \(currencySuffix)"
    }
    
    static func operationLabel(operation: String) -> String {
        
        switch operation {
            
        case "sale":
            return LocalizationKeys.sale.localized
            
        case "rent":
            return LocalizationKeys.rent.localized
            
        default:
            return operation.capitalized
        }
    }
    
    static func sizeFormat(size: Double) -> String {
        return "\(Int(size)) m²"
    }
    
    static func flatInfoDescrition(rooms: Int, bathrooms: Int) -> String {
        let roomsText = rooms == 1 ? LocalizationKeys.room.localized : LocalizationKeys.rooms.localized
        let bathroomsText = bathrooms == 1 ? LocalizationKeys.bathroom.localized : LocalizationKeys.bathrooms.localized
        
        return "\(rooms) \(roomsText) · \(bathrooms) \(bathroomsText)"
    }
    
    static func format(rooms: Int) -> String {
        let roomsText = rooms == 1 ? "1 \(LocalizationKeys.room.localized)" : "\(rooms) \(LocalizationKeys.rooms.localized)"
        return roomsText
    }
    
    static func format(bathrooms: Int) -> String {
        let bathroomsText = bathrooms == 1 ? "1 \(LocalizationKeys.bathroom.localized)" : "\(bathrooms) \(LocalizationKeys.bathrooms.localized)"
        return bathroomsText
    }
    
    static func floorDescription(floor: String, localized: Bool = false) -> String {
        return "\(LocalizationKeys.floor.localized) \(floor)"
    }
    
    static func communityFees(cost: Double, currency: String) -> String {
        return "\(cost) \(currency)/mes"
    }
    
    static func districtFormat(district: String, municipality: String) -> String {
        return "\(district), \(municipality)"
    }
}

extension Date {
    
    func formatSavedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
