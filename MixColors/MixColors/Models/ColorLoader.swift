//
//  ColorLoader.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//


import Foundation
import SwiftUI

class ColorLoader: ObservableObject {
    @Published var colors: [NamedColor] = []
    
    init() {
        loadColors()
    }
    
    func findNearestColor(to targetColor: Color) -> NamedColor? {
        // логика поиска по self.colors
        var minDistance: Double = .greatestFiniteMagnitude
        var nearestColor: NamedColor?
        
        for color in self.colors {
            let distance = targetColor.distance(to: color.swiftColor)
            if distance < minDistance {
                minDistance = distance
                nearestColor = color
            }
        }
        
        return nearestColor
    }
    
    func loadColors() {
        guard let url = Bundle.main.url(forResource: "colors", withExtension: "json") else {
            print("❌ Не найден файл colors.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedColors = try JSONDecoder().decode([NamedColor].self, from: data)
            DispatchQueue.main.async {
                // Определяем порядок основных цветов
                let colorOrder = ["red", "orange", "yellow", "green", "blue", "purple", "pink", "brown", "white", "gray", "black"]
                
                self.colors = decodedColors.sorted { color1, color2 in
                    // Получаем первое семейство каждого цвета
                    let family1 = color1.families.first ?? ""
                    let family2 = color2.families.first ?? ""
                    
                    // Индексы в порядке сортировки
                    let index1 = colorOrder.firstIndex(of: family1) ?? Int.max
                    let index2 = colorOrder.firstIndex(of: family2) ?? Int.max
                    
                    // Если разные семейства - сортируем по порядку
                    if index1 != index2 {
                        return index1 < index2
                    }
                    
                    // Если одно семейство - сортируем по hex
                    return color1.hex < color2.hex
                }
            }
            print("✅ Загружено \(decodedColors.count) цветов")
        } catch let DecodingError.dataCorrupted(context) {
            print("❌ Данные повреждены: \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ Ключ '\(key)' не найден: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("❌ Несоответствие типа '\(type)': \(context.debugDescription)")
        } catch {
            print("❌ Общая ошибка: \(error.localizedDescription)")
        }
    }
}
