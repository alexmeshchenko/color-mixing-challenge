//
//  Bundle+Language.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import Foundation
import ObjectiveC.runtime

// MARK: - LocalizedBundle

final class LocalizedBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let language = Bundle.currentLanguage
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}


// MARK: - Bundle Extension

extension Bundle {
    static var currentLanguage: String {
        UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
    }
    
    static func setLanguage(_ language: String) {
        LocalizationLogger.log(" [Bundle] Switching main bundle to language: \(language)")
        
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        object_setClass(Bundle.main, LocalizedBundle.self)
    }
}
