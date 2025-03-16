//
//  Untitled.swift
//  IdealistaChallenge
//

import Foundation

typealias Localizable = String

extension Localizable {
    
    var localized: Localizable {
        
        guard let bundle = Bundle.getBundle() else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    
    func localized(comment: String) -> Localizable {
        NSLocalizedString(self, comment: comment)
    }
}

extension Bundle {
    
    fileprivate static func getBundle() -> Bundle? {
        
        let currentLanguage = getCurrentAppLanguage()
        
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            return Bundle(path: path)
        }
        
        return nil
    }
    
    public static func getCurrentAppLanguage() -> String {
        
        if let language = UserDefaults.standard.object(forKey: "currentLanguage") as? [String] {
            if let current = language.first {
                return current
            }
        }
        
        return getPreferredLanguage().languageCode?.identifier ?? "es"
    }
    
    private static func getPreferredLanguage() -> Locale.Language {
        
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current.language
        }
        
        return Locale(identifier: preferredIdentifier).language
    }
}
