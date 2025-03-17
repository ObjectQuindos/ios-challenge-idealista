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
