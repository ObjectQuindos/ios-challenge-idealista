//
//  RealEstateDetail+Domain.swift
//  IdealistaChallenge
//

import Foundation

extension RealEstateDetail {
    
    func formatPrice() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            return "\(formattedPrice) \(priceInfo.currencySuffix)"
        }
        
        return "\(price) \(priceInfo.currencySuffix)"
    }
    
    func getOperationLabel() -> String {
        
        switch operation {
        case "sale":
            return "Venta"
        case "rent":
            return "Alquiler"
        default:
            return operation.capitalized
        }
    }
    
    func formatSize() -> String {
        return "\(moreCharacteristics.constructedArea) m²"
    }
    
    func formatRoomsAndBathrooms() -> String {
        let rooms = moreCharacteristics.roomNumber
        let baths = moreCharacteristics.bathNumber
        
        let roomsText = rooms == 1 ? "1 habitación" : "\(rooms) habitaciones"
        let bathsText = baths == 1 ? "1 baño" : "\(baths) baños"
        
        return "\(roomsText), \(bathsText)"
    }
    
    func getFloorText() -> String {
        return "Planta \(moreCharacteristics.floor)"
    }
    
    func getExtras() -> [String] {
        var extras: [String] = []
        
        if moreCharacteristics.lift {
            extras.append("Ascensor")
        }
        
        if moreCharacteristics.boxroom {
            extras.append("Trastero")
        }
        
        if moreCharacteristics.exterior {
            extras.append("Exterior")
        } else {
            extras.append("Interior")
        }
        
        if moreCharacteristics.isDuplex {
            extras.append("Dúplex")
        }
        
        return extras
    }
    
    func getFormattedCommunityFees() -> String {
        return "\(moreCharacteristics.communityCosts) \(priceInfo.currencySuffix)/mes"
    }
    
    func getPropertyTypeText() -> String {
        switch propertyType {
        case "homes":
            return homeType == "flat" ? "Piso" : "Casa"
        default:
            return propertyType.capitalized
        }
    }
}
