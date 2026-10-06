//
//  Settings.swift
//  Saturn
//
//  Created by Daniel Correia on 19.03.23.
//

import SwiftUI
import Foundation

class SettingsController: ObservableObject {
    
    func addSettings() {
        DeleteAllSettings()
        
        // New
        
        let userInfo = fetchOrCreateSettingGroup(key: "userInfo", title: "User", order: 1, iconName: "")
        let customization1 = fetchOrCreateSettingGroup(key: "customization", title: "Customization", order: 2, iconName: "")
        
        _ = addStringSetting(key: "name", title: "Name", group: userInfo, order: 1)
        _ = addBoolSetting(key: "onboard", title: "Onboarding", group: userInfo, value: false, order: 2)
        _ = addDateSetting(key: "firstUse", title: "First Use", group: userInfo, order: 3)
        _ = addDateSetting(key: "lastUse", title: "Last Use", group: userInfo, order: 4)
        
        let background = addBoolSetting(key: "showBg", title: "Background", group: customization1, value: false, order: 1)
        let _ = addStringSetting(key: "background", title: "Background", group: customization1, value: "wwwhirl", type: "Background", order: 2)
        let opacity = addDoubleSetting(key: "opacity", title: "Opacity", group: customization1, value: 0.5, minDouble: 0.2, maxDouble: 0.8, type: "Slider", order: 3)
        let _ = addDoubleSetting(key: "tertiaryColorOpacity", title: "Tertiary Opacity", group: customization1, value: 1.0, minDouble: 0.8, maxDouble: 1.0, type: "Slider", order: 4)
        _ = addStringSetting(key: "accentColor", title: "Accent Color", group: customization1, value: "appOrange", type: "Color", order: 5)
        _ = addBoolSetting(key: "hapticsOn", title: "Haptics", group: customization1, order: 6)
        let sO = addBoolSetting(key: "soundsOn", title: "Sounds", group: customization1, order: 7)
        let v = addDoubleSetting(key: "soundsVolume", title: "Volume", group: customization1, value: 0.5, minDouble: 0.01, maxDouble: 0.5, type: "Slider", order: 8, enabled: false)
        _ = addBoolSetting(key: "showBorder", title: "Future Mode", group: customization1, order: 9)
        _ = addButtonSetting(key: "reportProblem", title: "Report Problem", group: customization1, order: 10, function: "reportProblem")
        _ = addButtonSetting(key: "export", title: "Export Data", group: customization1, order: 11, function: "export")
        _ = addButtonSetting(key: "import", title: "Import Data", group: customization1, order: 12, function: "import")
        _ = addButtonSetting(key: "reset", title: "Reset Data", group: customization1, order: 13, function: "reset")
        
        sO.addToDependents(v)
        background.addToDependents(opacity)
        PersistenceController.save()
    }
    
    public func setName(name: String) {
        let setting = self.getSetting(key: "name")
        setting!.stringValue = name
        PersistenceController.save()
    }
    
    public func setFirstUse(date: Date) {
        let setting = self.getSetting(key: "firstUse")
        setting?.dateValue = date
        PersistenceController.save()
    }
}

func DeleteAllSettings() {
    let context = PersistenceController.shared.container.viewContext
    DataUtils.wipeSettings(context: context)
    DataUtils.wipeSettingGroups(context: context)
    PersistenceController.save()
}

public var Name: String {
    get {
        return SettingsController.getStringValue(key: "name") ?? "Player 1"
    }
}

public var OnBoard: Bool {
    get {
        return SettingsController.getBoolValue(key: "onboard") ?? false
    }
}

public func SetOnboard(onboard: Bool) {
    let setting = SettingsController.getSetting(key: "onboard")
    setting?.boolValue = onboard
    PersistenceController.save()
}

public var FirstUse: Date {
    get {
        return SettingsController.getDateValue(key: "firstUse") ?? Date()
    }
}

public func SetFirstUse(date: Date) {
    let setting = SettingsController.getSetting(key: "firstUse")
    setting?.dateValue = date
    PersistenceController.save()
}

public var SoundsOn: Bool {
    get {
        return SettingsController.getBoolValue(key: "soundsOn") ?? false
    }
}

public var HapticsOn: Bool {
    get {
        return SettingsController.getBoolValue(key: "hapticsOn") ?? false
    }
}

public var SoundsVolume: Double {
    get {
        return SettingsController.getDoubleValue(key: "soundsVolume") ?? 0.5
    }
}

public var Background: String {
    get {
        return SettingsController.getStringValue(key: "background") ?? "0"
    }
}

public var ShowBg: Bool {
    get {
        return SettingsController.getBoolValue(key: "showBg") ?? false
    }
}

public var AccentColor: String {
    get {
        return SettingsController.getStringValue(key: "accentColor") ?? "Orange"
    }
}

public var Opacity: Double {
    get {
        return SettingsController.getDoubleValue(key: "opacity") ?? 0.5
    }
}

public var DefaultPeriod: Int16 {
    get {
        return Int16(SettingsController.getIntValue(key: "defaultPeriod") ?? 3)
    }
}

public var TertiaryColorOpacity: Double {
    get {
        return SettingsController.getDoubleValue(key: "tertiaryColorOpacity") ?? 1.0
    }
}

public var ShowBorder: Bool {
    get {
        return SettingsController.getBoolValue(key: "showBorder") ?? false
    }
}

public func SetLastUse(date: Date) {
    let setting = SettingsController.getSetting(key: "lastUse")
    setting?.dateValue = date
    PersistenceController.save()
}
