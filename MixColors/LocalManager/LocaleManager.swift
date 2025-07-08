//
//  LocaleManager.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 07.07.25.
//

import Foundation
import SwiftUI

final class LocaleManager: ObservableObject {
    @Published var locale: Locale
    
    static let shared = LocaleManager()
    
    private init() {
        let defaultCode = Locale.current.language.languageCode?.identifier ?? "en"
        let savedCode = UserDefaults.standard.string(forKey: "selectedLanguage") ?? defaultCode
        self.locale = Locale(identifier: savedCode)
        Bundle.setLanguage(savedCode)
    }
    
    func setLanguage(_ code: String) {
        guard locale.identifier != code else {
            LocalizationLogger.log(" [Manager] Language \(code) already set — skipping")
            return
        } // ✅ избегаем повторной установки
        
        UserDefaults.standard.set(code, forKey: "selectedLanguage")
        Bundle.setLanguage(code)                        // ✅ обязательно: применяем хак
        locale = Locale(identifier: code)               // ✅ обновляем Published (меняет .environment)
    }
}
