//
//  ColorUtils.swift
//  Venus
//
//  Created by Daniel Correia on 22.09.22.
//

import Foundation
import SwiftUI

public class ColorUtils {
    
    static func getColorFromDescription(colorScheme: ColorScheme, colorName: String) -> Color {
        switch(colorName) {
        case "Pink": return colorScheme == .dark ? Color("Pink") : Color("pink4")
        case "Purple": return colorScheme == .dark ? Color("Purple") : Color("purple4")
        case "Orange": return colorScheme == .dark ? Color("Orange") : Color("orange4")
        case "Yellow": return colorScheme == .dark ? Color("Yellow") : Color("yellow4")
        case "Red": return colorScheme == .dark ? Color("Red") : Color("red4")
        case "Cyan": return colorScheme == .dark ? Color("Cyan") : Color("teal4")
        case "Grey": return colorScheme == .dark ? Color("Grey") : Color("grey4")
        case "Green": return colorScheme == .dark ? Color("Green") : Color("green4")
        case "Black": return colorScheme == .dark ? Color("Black") : Color("Black")
        default:
            return .primary == .black ? Color("Black") : Color("White")
        }
    }
    
    static func getColor(colorScheme: ColorScheme, colorName: String) -> Color {
        switch(colorName) {
        case "Pink": return colorScheme == .dark ? Color("Pink") : Color("pink4")
        case "Purple": return colorScheme == .dark ? Color("Purple") : Color("purple4")
        case "Orange": return colorScheme == .dark ? Color("Orange") : Color("orange4")
        case "Yellow": return colorScheme == .dark ? Color("Yellow") : Color("yellow4")
        case "Red": return colorScheme == .dark ? Color("Red") : Color("red4")
        case "Cyan": return colorScheme == .dark ? Color("Cyan") : Color("teal4")
        case "Grey": return colorScheme == .dark ? Color("Grey") : Color("grey4")
        case "Green": return colorScheme == .dark ? Color("Green") : Color("green4")
        case "Black": return colorScheme == .dark ? Color("Black") : Color("Black")
        default:
            return .primary == .black ? Color("Black") : Color("White")
        }
    }
}
