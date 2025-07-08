//
//  MixColorsApp.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import SwiftUI

@main
struct MixColorsApp: App {
    @StateObject private var localeManager = LocaleManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, localeManager.locale)
        }
    }
}
