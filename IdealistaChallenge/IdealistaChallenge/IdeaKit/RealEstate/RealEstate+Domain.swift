//
//  RealEstate+Domain.swift
//  IdealistaChallenge
//

import Foundation

extension RealEstate {
    
    func formatPrice() -> String {
        
        return PropertyFormatters.formatPrice(
            price: self.price,
            currencySuffix: self.priceInfo.price.currencySuffix
        )
    }
    
    func formatSaveDate() -> String? {
        self.createdAt?.formatSavedDate()
    }
    
    func formatSize() -> String {
        return PropertyFormatters.sizeFormat(size: self.size)
    }
    
    func formatRoomsBathrooms() -> String {
        PropertyFormatters.flatInfoDescrition(rooms: self.rooms, bathrooms: self.bathrooms)
    }
    
    func getFloor() -> String {
        return PropertyFormatters.floorDescription(floor: self.floor)
    }
    
    func flatInfo() -> String {
        
        //let roomsText = self.rooms == 1 ? LocalizationKeys.room.localized : LocalizationKeys.rooms.localized
        //let bathroomsText = self.bathrooms == 1 ? LocalizationKeys.bathroom.localized : LocalizationKeys.bathrooms.localized
        
        return "\(self.formatRoomsBathrooms()) · \(self.formatSize()) · \(self.getFloor())"
    }
    
    func getOperationLabel() -> String {
        return PropertyFormatters.operationLabel(operation: self.operation)
    }
    
    func getAddress() -> String {
        return "\(self.address), \(self.neighborhood)"
    }
    
    func fullAddress() -> String {
        return "\(propertyType.localized) \(LocalizationKeys.i_n.localized) \(getAddress())"
    }
    
    func getDistrict() -> String {
        return PropertyFormatters.districtFormat(district: district, municipality: municipality)
    }
}
