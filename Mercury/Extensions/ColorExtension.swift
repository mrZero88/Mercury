//
//  ColorExtension.swift
//  Venus
//
//  Created by Daniel Correia on 07.10.22.
//

import Foundation
import SwiftUI

extension Color {
    
    static var ColorTernary: Color {
        get {
            return ColorUtils.getColorFromDescription(colorName: SettingsController.getStringValue(key: "accentColor") ?? "", concat: "Ternary")
        }
    }
    
    static var ColorSecondary: Color {
        get {
            return ColorUtils.getColorFromDescription(colorName: SettingsController.getStringValue(key: "accentColor") ?? "", concat: "Secondary")
        }
    }
    
    static var ColorLight: Color {
        get {
            return ColorUtils.getColorFromDescription(colorName: SettingsController.getStringValue(key: "accentColor") ?? "", concat: "Light")
        }
    }
    
    static var Color: Color {
        get {
            return ColorUtils.getColorFromDescription(colorName: SettingsController.getStringValue(key: "accentColor") ?? "")
        }
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
