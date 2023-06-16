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
public let Bg2Description = "Stars"
public let MinPhasesCountPerBoard = 2
public let MaxPhasesCountPerBoard = 8
public let PanelColor = Color("PanelColor")
public let DefaultThemeIconName = "7082272_image_photo_photography_picture"
public let DefaultTopicIconName = "7082272_image_photo_photography_picture"

public let DefaultWidgetCardTitle = "Mercury"
public let DefaultWidgetCardSubtitle = "planet"
public let DefaultWidgetCardText1 = "Mercury is the first planet from the Sun and the smallest planet in the Solar System."
public let DefaultWidgetCardText2 = "It is a terrestrial planet with a heavily cratered surface due to the planet having no geological activity and an extremely tenuous atmosphere (called an exosphere)."

public let DefaultNoTopicTitle = "No Topics"
public let DefaultNoTopicSubtitle = "Welcome to Mercury!"
public let DefaultNoTopicText1 = "Hello" + (UserName.isEmpty ? "" : " " + UserName) + "! At the moment you don't have any topics to be shown here in the widgets."
public let DefaultNoTopicText2 = "To be able to see your created topic widgets, please create them in the app interface.\nYou can click here in the widget to open the app and start customizing it with useful information.\nHave Fun! :-D"

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
}

public enum EPeriod {
    case day, week, month, year, decade
}
