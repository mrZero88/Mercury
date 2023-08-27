//
//  SvgBackground.swift
//  Alien
//
//  Created by Daniel Correia on 10.04.23.
//

import SwiftUI

struct SvgBackgroundView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Environment(\.colorScheme) var colorScheme
    
    var svgName: String {
        get {
            switch(AccentColor) {
            case "Orange": return getColor(color: "Orange")
            case "Cyan": return getColor(color: "Cyan")
            case "Green": return getColor(color: "Green")
            case "Pink": return getColor(color: "Pink")
            case "Yellow": return getColor(color: "Yellow")
            case "Purple": return getColor(color: "Purple")
            case "Red": return getColor(color: "Red")
            case "Black": return getColor(color: "Black")
            case "White": return getColor(color: "White")
            default: return getColor(color: "Cyan")
            }
        }
    }
    
    func getColor(color: String) -> String {
        if(colorScheme == .dark) {
            return Background + "_d" + color
        }
        return Background + "_l" + color
    }
    
    var body: some View {
        if(ShowBg1) {
            Image(Background).resizable().scaledToFill().opacity(0.25).ignoresSafeArea().foregroundColor(Color.accentColor)
        }
    }
}

struct SvgBackground_Previews: PreviewProvider {
    static var previews: some View {
        SvgBackgroundView()
    }
}
