//
//  AppLanguage.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 08.07.25.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case en, ru, sr, sv
    
    var id: String { rawValue }
    
    var displayCode: String {
        rawValue.uppercased()
    }
    
    var locale: Locale {
        Locale(identifier: self.rawValue)
    }
    
    var nativeName: String {
        Locale(identifier: rawValue).localizedString(forLanguageCode: rawValue)?.capitalized ?? rawValue
    }
}
