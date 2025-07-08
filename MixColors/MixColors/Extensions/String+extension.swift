//
//  String+extension.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import Foundation

extension String {
    var colorLocalized: String {
        String(localized: String.LocalizationValue(self), table: "Colors")
    }
    
    var uiLocalized: String {
        String(localized: String.LocalizationValue(self), table: "UI")
    }
}
