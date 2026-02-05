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
        
        let userInfo = fetchOrCreateSettingGroup(key: "userInfo", title: "User", order: 1, iconName: "")
        let customization1 = fetchOrCreateSettingGroup(key: "customization", title: "Customization", order: 2, iconName: "")
        
        _ = addStringSetting(key: "username", title: "Username", group: userInfo, order: 1)
        _ = addUuidSetting(key: "useruuid", title: "UUUID", group: userInfo, order: 2)
        _ = addBoolSetting(key: "onboard", title: "Onboarding", group: userInfo, value: false, order: 3)
        _ = addDateSetting(key: "firstOnDate", title: "First Use Date", group: userInfo, order: 4)
        _ = addDateSetting(key: "lastOnDate", title: "Last Use Date", group: userInfo, order: 5)
        //_ = addIntSetting(key: "defaultPeriod", title: "Default Period", group: userInfo, value: 3, type: "Period", order: 6)
        
        let _ = addBoolSetting(key: "showBg", title: "Background", group: customization1, value: false, order: 1)
        let _ = addStringSetting(key: "background", title: "Background", group: customization1, value: "wwwhirl", type: "Background", order: 2)
        let _ = addDoubleSetting(key: "opacity", title: "Opacity", group: customization1, value: 0.5, minDouble: 0.2, maxDouble: 0.8, type: "Slider", order: 3)
        let _ = addDoubleSetting(key: "tertiaryColorOpacity", title: "Tertiary Opacity", group: customization1, value: 1.0, minDouble: 0.8, maxDouble: 1.0, type: "Slider", order: 4)
        _ = addStringSetting(key: "accentColor", title: "Accent Color", group: customization1, value: "Orange", type: "Color", order: 5)
        _ = addBoolSetting(key: "hapticsOn", title: "Haptics", group: customization1, order: 6)
        let sO = addBoolSetting(key: "soundsOn", title: "Sounds", group: customization1, order: 7)
        let v = addDoubleSetting(key: "soundsVolume", title: "Volume", group: customization1, value: 0.5, minDouble: 0.01, maxDouble: 0.5, type: "Slider", order: 8, enabled: false)
        _ = addButtonSetting(key: "export", title: "Export Data", group: customization1, order: 9, function: "export")
        _ = addButtonSetting(key: "import", title: "Import Data", group: customization1, order: 10, function: "import")
        _ = addButtonSetting(key: "reset", title: "Reset Data", group: customization1, order: 11, function: "reset")
        
        sO.addToDependents(v)
        
        //sB1.addToDependents(bg1Opacity)
        //sB2.addToDependents(aBg2)
        //sB2.addToDependents(bg2Opacity)
        
        self.setAppFirstUseDate(date: Date())
        PersistenceController.save()
    }
    
    public func setUserName(userName: String) {
        let setting = self.getSetting(key: "username")
        setting!.stringValue = userName
        PersistenceController.save()
    }
    
    public func setAppFirstUseDate(date: Date) {
        let setting = self.getSetting(key: "appFirstUseDate")
        setting?.dateValue = date
        PersistenceController.save()
    }
}

func DeleteAllSettings() {
    let settings = SettingDao.fetchAllSettings()
    for setting in settings {
        setting.delete()
    }
    let groups = SettingsGroupDao.fetchAllSettingGroups()
    for group in groups {
        group.delete()
    }
}

public var UserName: String {
    get {
        return SettingsController.getStringValue(key: "username") ?? "Player 1"
    }
}

public var UserUuid: UUID {
    get {
        return SettingsController.getUuidValue(key: "useruuid") ?? UUID()
    }
}

public func SetUserUuid(uuid: UUID) {
    let setting = SettingsController.getSetting(key: "useruuid")
    setting?.uuidValue = uuid
    PersistenceController.save()
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

public var FirstOnDate: Date {
    get {
        return SettingsController.getDateValue(key: "firstOnDate") ?? Date()
    }
}

public func SetFirstOnDate(date: Date) {
    let setting = SettingsController.getSetting(key: "firstOnDate")
    setting?.dateValue = date
    PersistenceController.save()
}

public var LastOnDate: Date {
    get {
        return SettingsController.getDateValue(key: "lastOnDate") ?? Date()
    }
}

public func SetLastOnDate(date: Date) {
    let setting = SettingsController.getSetting(key: "lastOnDate")
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

public var TertiaryColorOpacity: Double {
    get {
        return SettingsController.getDoubleValue(key: "tertiaryColorOpacity") ?? 1.0
    }
}

public var DefaultPeriod: Int16 {
    get {
        return Int16(SettingsController.getIntValue(key: "defaultPeriod") ?? 3)
    }
}
