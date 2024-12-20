//
//  Config.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation
import SwiftUI

public let PanelHeight = CGFloat(280)
public let BorderPadding = CGFloat(10)
public let CornerRadius = CGFloat(5)
public let Border5 = CGFloat(5)
public let Bg2Description = "Stars"
public let MinPhasesCountPerBoard = 2
public let MaxPhasesCountPerBoard = 8
public let PanelColor = Color("PanelColor")
public let DefaultThemeIconName = "7082272_image_photo_photography_picture"
public let DefaultTopicIconName = "7082272_image_photo_photography_picture"

public let DefaultWidgetCardTitle = String(localized: String.LocalizationValue("Mercury"))
public let DefaultWidgetCardSubtitle = String(localized: String.LocalizationValue("planet"))
public let DefaultWidgetCardThemeTitle = String(localized: String.LocalizationValue("Universe"))
public let DefaultWidgetCardText1 = String(localized: String.LocalizationValue("Mercury is the first planet from the Sun and the smallest planet in the Solar System."))
public let DefaultWidgetCardText2 = String(localized: String.LocalizationValue("It is a terrestrial planet with a heavily cratered surface due to the planet having no geological activity and an extremely tenuous atmosphere (called an exosphere)."))

public let DefaultNoTopicTitle = String(localized: String.LocalizationValue("No Topics"))
public let DefaultNoTopicSubtitle = String(localized: String.LocalizationValue("Welcome to Mercury!"))
public let DefaultNoTopicText1 = String(localized: String.LocalizationValue("Hello")) + (UserName.isEmpty ? "" : " " + UserName) + "! " + String(localized: String.LocalizationValue("At the moment you don't have any topics to be shown here in the widgets."))
public let DefaultNoTopicText2 = String(localized: String.LocalizationValue("To be able to see your created topic widgets, please create them in the app interface.\n\nYou can click here in the widget to open the app and start customizing it with useful information."))

public let DefautSelectedGroup: String = "Animal Kingdom"

#if os(iOS)
public let TertiaryColor: Color = Color(uiColor: UIColor.tertiarySystemBackground)
#else
public let TertiaryColor: Color = Color.secondary
#endif

public var IconsPerPage: Int {
    get {
        return UIDevice.isIPad ? 15 : 24
    }
}

public var IconsPerRow: Int {
    get {
        return UIDevice.isIPad ? 5 : 4
    }
}

class Config {
    static func getPriorityColor(priority: Int16) -> Color {
        switch(priority) {
        case 1: return Color("red1")
        case 2: return Color("orange1")
        case 3: return Color("White")
        case 4: return Color("blue1")
        case 5: return Color("green1")
        default:
            return Color("green1")
        }
    }
    
    static var periods: [Period] =
    [
        Period(id: 1, description: "Daily", period: .day),
        Period(id: 2, description: "Weekly", period: .week),
        Period(id: 3, description: "Monthly", period: .month),
        Period(id: 4, description: "Yearly", period: .year)
    ]
}

public enum EPeriod {
    case day, week, month, year, decade
}
