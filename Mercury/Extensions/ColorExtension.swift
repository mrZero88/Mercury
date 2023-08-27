//
//  ColorExtension.swift
//  Venus
//
//  Created by Daniel Correia on 07.10.22.
//

import Foundation
import SwiftUI

extension Color {
    
    static func getColor(colorScheme: ColorScheme) -> Color {
        return ColorUtils.getColorFromDescription(colorScheme: colorScheme, colorName: SettingsController.getStringValue(key: "accentColor") ?? "")
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
