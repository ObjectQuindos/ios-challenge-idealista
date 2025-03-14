//
//  RealEstate+Domain.swift
//  IdealistaChallenge
//

import Foundation

extension RealEstate {
    
    func formatPrice() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        
        if let formattedNumber = formatter.string(from: NSNumber(value: self.price)) {
            return "\(formattedNumber) \(self.priceInfo.price.currencySuffix)"
        }
        
        return "\(self.price) \(self.priceInfo.price.currencySuffix)"
    }
    
    func formatSize() -> String {
        return "\(Int(self.size)) m²"
    }
    
    func formatRoomsAndBathrooms() -> String {
        let roomsText = self.rooms == 1 ? "habitación" : "habitaciones"
        let bathroomsText = self.bathrooms == 1 ? "baño" : "baños"
        
        return "\(self.rooms) \(roomsText) · \(self.bathrooms) \(bathroomsText)"
    }
    
    func getOperationLabel() -> String {
        
        switch self.operation {
        case "sale":
            return "Venta"
        case "rent":
            return "Alquiler"
        default:
            return self.operation.capitalized
        }
    }
    
    func getAddress() -> String {
        return "\(self.address), \(self.neighborhood)"
    }
}
