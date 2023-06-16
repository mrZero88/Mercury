//
//  ColorUtils.swift
//  Venus
//
//  Created by Daniel Correia on 22.09.22.
//

import Foundation
import SwiftUI

public class ColorUtils {
    static func getColorFromDescription(colorName: String, number: Int) -> Color {
        switch(colorName) {
        case "Pink": return Color("pink" + String(number))
        case "Purple": return Color("purple" + String(number))
        case "Orange": return Color("orange" + String(number))
        case "Yellow": return Color("yellow" + String(number))
        case "Red": return Color("red" + String(number))
        case "Cyan": return Color("teal" + String(number))
        case "Grey": return Color("grey" + String(number))
        case "Green": return Color("green" + String(number))
        default:
            return .primary == .black ? Color("Black") : Color("White")
        }
    }
    
    static func getColorFromDescription(colorName: String, concat: String = "") -> Color {
        switch(colorName) {
        case "Pink": return Color("Pink" + concat)
        case "Purple": return Color("Purple" + concat)
        case "Orange": return Color("Orange" + concat)
        case "Yellow": return Color("Yellow" + concat)
        case "Red": return Color("Red" + concat)
        case "Cyan": return Color("Cyan" + concat)
        case "Grey": return Color("Grey" + concat)
        case "Green": return Color("Green" + concat)
        default:
            return .primary == .black ? Color("Black") : Color("White")
        }
    }
}
