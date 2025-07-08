//
//  Color+Distance.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import SwiftUI

extension Color {
    /// Вычисляет расстояние между двумя цветами в RGB пространстве
    /// - Parameter other: Другой цвет для сравнения
    /// - Returns: Расстояние между цветами (0.0 = идентичные цвета)
    func distance(to other: Color) -> Double {
        let uiColor1 = UIColor(self)
        let uiColor2 = UIColor(other)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // Вычисляем Euclidean distance в RGB пространстве
        let rDiff = r1 - r2
        let gDiff = g1 - g2
        let bDiff = b1 - b2
        
        let distance = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        
        return Double(distance)
    }
}
