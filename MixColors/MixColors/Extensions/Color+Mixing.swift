//
//  Color+Mixing.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import SwiftUI

extension Color {
    /// Смешивает текущий цвет с другим в заданной пропорции
    /// - Parameters:
    ///   - other: Цвет для смешивания
    ///   - ratio: Пропорция смешивания (0.0 = 100% self, 1.0 = 100% other)
    /// - Returns: Результат смешивания
    func mixed(with other: Color, ratio: Double = 0.5) -> Color {
        // логика смешивания
        let uiColor1 = UIColor(self)
        let uiColor2 = UIColor(other)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // Смешиваем с учетом ratio
        let mixedR = r1 * (1 - ratio) + r2 * ratio
        let mixedG = g1 * (1 - ratio) + g2 * ratio
        let mixedB = b1 * (1 - ratio) + b2 * ratio
        let mixedA = a1 * (1 - ratio) + a2 * ratio
        
        return Color(UIColor(red: mixedR, green: mixedG, blue: mixedB, alpha: mixedA))
    }
}
