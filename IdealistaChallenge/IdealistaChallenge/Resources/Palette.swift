//
//  Palette.swift
//  IdealistaChallenge
//

import UIKit

struct IdealistaColors {
    //rgb(221,229,182)
    static let primary = UIColor(red: 217/255, green: 237/255, blue: 146/255, alpha: 1.0)
    static let primarySoft = UIColor(red: 221/255, green: 229/255, blue: 182/255, alpha: 1.0)
    static let secondary = UIColor(red: 46/255, green: 117/255, blue: 182/255, alpha: 1.0)
    static let tertiary = UIColor(red: 225/255, green: 0/255, blue: 152/255, alpha: 1.0)
    
    static let background = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    static let cardBackground = UIColor.white
    
    static let darkText = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    static let mediumText = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    static let lightText = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
}

extension UIColor {
    
    static var primaryColor: UIColor {
        return IdealistaColors.primary
    }
    
    static var primarySoftColor: UIColor {
        return IdealistaColors.primarySoft
    }
    
    static var secondaryColor: UIColor {
        return IdealistaColors.secondary
    }
    
    static var tertiaryColor: UIColor {
        return IdealistaColors.tertiary
    }
    
    static var backgroundCustomColor: UIColor {
        return IdealistaColors.background
    }
    
    static var cardBackgroundColor: UIColor {
        return IdealistaColors.cardBackground
    }
    
    static var darkTextColor: UIColor {
        return IdealistaColors.darkText
    }
    
    static var mediumTextColor: UIColor {
        return IdealistaColors.mediumText
    }
    
    static var lightTextColor: UIColor {
        return IdealistaColors.lightText
    }
}

extension RealEstate {
    
    func getOperationColor() -> UIColor {
        
        switch self.operation {
            
        case "sale":
            return .secondaryColor
            
        case "rent":
            return .tertiaryColor
            
        default:
            return .primaryColor
        }
    }
}
