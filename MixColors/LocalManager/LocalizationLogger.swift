//
//  LocalizationLogger.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 08.07.25.
//


import Foundation

enum LocalizationLogger {
    static var isEnabled: Bool = true
    
    static func log(_ message: String,
                    file: String = #fileID,
                    function: String = #function,
                    line: Int = #line) {
#if DEBUG
        guard isEnabled else { return }
        let fileName = (file as NSString).lastPathComponent
        print("[Localization] \(fileName):\(line) → \(function): \(message)")
#endif
    }
}
