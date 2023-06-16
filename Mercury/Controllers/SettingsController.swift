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
        
        deleteSettingGroup(key: "userInfo");
        deleteSettingGroup(key: "customization0");
        deleteSettingGroup(key: "customization");
        
        deleteSetting(key: "username");
        deleteSetting(key: "useruuid");
        deleteSetting(key: "onboard");
        deleteSetting(key: "beginningDate");
        
        deleteSetting(key: "soundsOn")
        deleteSetting(key: "soundsVolume")
        deleteSetting(key: "background")
        
        deleteSetting(key: "showBackground1")
        deleteSetting(key: "showBackground2")
        deleteSetting(key: "animateBg2")
        deleteSetting(key: "accentColor")
        deleteSetting(key: "background1Opacity")
        deleteSetting(key: "background2Opacity")
        
        let userInfo = fetchOrCreateSettingGroup(key: "userInfo", title: "User", order: 1, iconName: "")
        let customization1 = fetchOrCreateSettingGroup(key: "customization", title: "Customization", order: 2, iconName: "")
        
        _ = addStringSetting(key: "username", title: "Username", group: userInfo, order: 1)
        _ = addUuidSetting(key: "useruuid", title: "UUUID", group: userInfo, order: 2)
        _ = addBoolSetting(key: "onboard", title: "Onboarding", group: userInfo, value: false, order: 3)
        _ = addDateSetting(key: "beginningDate", title: "Beginning Date", group: userInfo, order: 4)
        _ = addButtonSetting(key: "reset", title: "Reset", group: userInfo, order: 5)
        
        let _ = addBoolSetting(key: "showBg1", title: "Background", group: customization1, value: true, order: 1)
        let _ = addStringSetting(key: "background", title: "Background", group: customization1, value: "blob", type: "Dropdown", order: 2)
        //let sB2 = addBoolSetting(key: "showBg2", title: "Show Bg. 2", group: customization1, value: false, order: 2)
        //let aBg2 = addBoolSetting(key: "animateBg2", title: "Animate Bg 2", group: customization1, value: false, order: 3)
        _ = addStringSetting(key: "accentColor", title: "Accent Color", group: customization1, value: "Red", type: "Color", order: 3)
        //let bg1Opacity = addDoubleSetting(key: "bg1Opacity", title: "Bg. 1 Opacity", group: customization1, value: 0.5, minDouble: 0.0, maxDouble: 0.5, type: "Slider", order: 5)
        //let bg2Opacity  = addDoubleSetting(key: "bg2Opacity", title: "Bg. 2 Opacity", group: customization1, value: 0.5, minDouble: 0.0, maxDouble: 1.0, type: "Slider", order: 6, enabled: false)
        
        let sO = addBoolSetting(key: "soundsOn", title: "Sounds", group: customization1, order: 4)
        let v = addDoubleSetting(key: "soundsVolume", title: "Volume", group: customization1, value: 0.5, minDouble: 0.01, maxDouble: 0.5, type: "Slider", order: 5, enabled: false)
        
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

public var BeginningDate: Date {
    get {
        return SettingsController.getDateValue(key: "beginningDate") ?? Date()
    }
}

public var SoundsOn: Bool {
    get {
        return SettingsController.getBoolValue(key: "soundsOn") ?? false
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

public var ShowBg1: Bool {
    get {
        return SettingsController.getBoolValue(key: "showBg1") ?? false
    }
}

public var ShowBg2: Bool {
    get {
        return SettingsController.getBoolValue(key: "showBg2") ?? false
    }
}

public var AnimateBg2: Bool {
    get {
        return SettingsController.getBoolValue(key: "animateBg2") ?? false
    }
}

public var AccentColor: String {
    get {
        return SettingsController.getStringValue(key: "accentColor") ?? "Orange"
    }
}

public var Bg1Opacity: Double {
    get {
        return SettingsController.getDoubleValue(key: "bg1Opacity") ?? 0.5
    }
}

public var Bg2Opacity: Double {
    get {
        return SettingsController.getDoubleValue(key: "bg2Opacity") ?? 0.5
    }
}
