//
//  SvgBackground.swift
//  Alien
//
//  Created by Daniel Correia on 10.04.23.
//

import SwiftUI
import CoreData

struct SvgBackgroundView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "background")
    ) var settingsBg: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "opacity")
    ) var settingsOp: FetchedResults<Setting>
    
    var svgName: String {
        get {
            switch(AccentColor) {
            case "appOrange": return getColor(color: "appOrange")
            case "appCyan": return getColor(color: "appCyan")
            case "appGreen": return getColor(color: "appGreen")
            case "appPink": return getColor(color: "appPink")
            case "appYellow": return getColor(color: "appYellow")
            case "appPurple": return getColor(color: "appPurple")
            case "appRed": return getColor(color: "appRed")
            case "appBlack": return getColor(color: "appBlack")
            case "appWhite": return getColor(color: "appWhite")
            default: return getColor(color: "appCyan")
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
        if(ShowBg) {
            Image(settingsBg.first?.stringValue ?? Background).resizable().ignoresSafeArea().scaledToFill().opacity(settingsOp.first?.doubleValue ?? Opacity).foregroundColor(Color.accentColor)
        }
    }
}

struct SvgBackground_Previews: PreviewProvider {
    static var previews: some View {
        SvgBackgroundView()
    }
}
