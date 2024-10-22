//
//  ColorExtension.swift
//  Venus
//
//  Created by Daniel Correia on 07.10.22.
//

import Foundation
import SwiftUI
import Utils

extension Color {
    
    static func getColor(colorScheme: ColorScheme, setting: Setting?) -> Color {
        return ColorUtils.getColorFromDescription(colorScheme: colorScheme, colorName: setting?.stringValue ?? SettingsController.getStringValue(key: "accentColor") ?? "")
    }
    
    static var ColorWhite: Color {
        get {
            return SwiftUI.Color("White")
        }
    }
    
    static var ColorBlack: Color {
        get {
            return SwiftUI.Color("Black")
        }
    }
}
