//
//  LanguagePickerView.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 07.07.25.
//

import SwiftUI

struct LanguagePickerView: View {
    @ObservedObject private var localeManager = LocaleManager.shared
    
    private var currentLanguage: AppLanguage {
        AppLanguage(rawValue: localeManager.locale.identifier) ?? .en
    }
    
    var body: some View {
        Menu {
            ForEach(AppLanguage.allCases) { lang in
                Button(lang.nativeName) {
                    changeLanguage(to: lang)
                }
            }
        } label: {
            Label(currentLanguage.displayCode, systemImage: "globe")
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
    
    private func changeLanguage(to language: AppLanguage) {
        guard currentLanguage != language else {
            LocalizationLogger.log("[Picker] \(language.displayCode) already selected — skipping")
            return
        }
        LocalizationLogger.log("[Picker] Changing language to \(language.displayCode)")
        localeManager.setLanguage(language.rawValue)
    }
}
