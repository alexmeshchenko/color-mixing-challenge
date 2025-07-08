//
//  NamedColor.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import Foundation
import SwiftUI

struct NamedColor: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let hex: String
    let rgb: String
    let families: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, hex, rgb, families
        // id не включаем в CodingKeys
    }
    
    var uiColor: UIColor {
        UIColor(hex: hex)
    }
    
    var swiftColor: Color {
        Color(uiColor)
    }
}
