//
//  SettingsControllerExtension.swift
//  Saturn
//
//  Created by Daniel Correia on 19.03.23.
//

import Foundation

extension SettingsController {
    
    func getSettings(key: String) -> [Setting] {
        return SettingDao.fetchSettings(key: key)
    }
    
    func getSetting(key: String) -> Setting? {
        return SettingDao.fetchSetting(key: key)
    }
    
    static func getSetting(key: String) -> Setting? {
        return SettingDao.fetchSetting(key: key)
    }
    
    static func getBoolValue(key: String) -> Bool? {
        return SettingDao.fetchSetting(key: key)?.boolValue
    }
    
    static func getIntValue(key: String) -> Int? {
        return SettingDao.fetchSetting(key: key)?.intValue != nil ? Int(SettingDao.fetchSetting(key: key)!.intValue) : nil
    }
    
    static func getDoubleValue(key: String) -> Double? {
        return SettingDao.fetchSetting(key: key)?.doubleValue != nil ? SettingDao.fetchSetting(key: key)!.doubleValue : nil
    }
    
    static func getDateValue(key: String) -> Date? {
        return SettingDao.fetchSetting(key: key)?.dateValue
    }
    
    static func getStringValue(key: String) -> String? {
        return SettingDao.fetchSetting(key: key)?.stringValue
    }
    
    static func getUuidValue(key: String) -> UUID? {
        return SettingDao.fetchSetting(key: key)?.uuidValue
    }
    
    func fetchOrCreateSettingGroup(key: String, title: String, order: Int16, iconName: String) -> SettingsGroup {
        return SettingsGroupDao.fetchOrCreateSettingGroup(key: key, title: title, order: order, iconName: iconName)
    }
    
    func addBoolSetting(key: String, title: String, group: SettingsGroup, value: Bool = false, type: String = "", order: Int16, dependentOn: Setting? = nil, isVisible: Bool = true, dataType: String = "Bool", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, boolValue: value, type: type, order: order, dependentOn: dependentOn, isVisible: isVisible, enabled: enabled)
    }
    
    func addIntSetting(key: String, title: String, group: SettingsGroup, value: Int = 0, type: String = "", order: Int16, isVisible: Bool = true, dataType: String = "Int", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, intValue: value, type: type, order: order, isVisible: isVisible, enabled: enabled)
    }
    
    func addDoubleSetting(key: String, title: String, group: SettingsGroup, value: Double = 0.0, minDouble: Double = 0.0, maxDouble: Double = 0.0, type: String = "", order: Int16, dependentOn: Setting? = nil, isVisible: Bool = true, dataType: String = "Double", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, doubleValue: value, minDouble: minDouble, maxDouble: maxDouble, type: type, order: order, dependentOn: dependentOn, isVisible: isVisible, enabled: enabled)
    }
    
    func addDateSetting(key: String, title: String, group: SettingsGroup, value: Date? = Date(), type: String = "", order: Int16, isVisible: Bool = true, dataType: String = "Date", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, dateValue: value, type: type, order: order, isVisible: isVisible, enabled: enabled)
    }
    
    func addButtonSetting(key: String, title: String, group: SettingsGroup, order: Int16, isVisible: Bool = true, enabled: Bool = true, function: String) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: "", group: group, type: "Button", order: order, isVisible: isVisible, enabled: enabled, function: function)
    }
    
    func addStringSetting(key: String, title: String, group: SettingsGroup, value: String = "", type: String = "", order: Int16, isVisible: Bool = true, dataType: String = "String", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, stringValue: value, type: type, order: order, isVisible: isVisible, enabled: enabled)
    }
    
    func addUuidSetting(key: String, title: String, group: SettingsGroup, value: UUID = UUID(), type: String = "", order: Int16, isVisible: Bool = true, dataType: String = "UUID", enabled: Bool = true) -> Setting {
        return SettingDao.fetchOrCreateSetting(title: title, key: key, dataType: dataType, group: group, uuidValue: value, type: type, order: order, isVisible: isVisible, enabled: enabled)
    }
    
    func updateBoolSetting(appSetting: Setting, value: Bool = false) {
        appSetting.boolValue = value
        appSetting.objectWillChange.send()
        self.objectWillChange.send()
        PersistenceController.save()
    }
    
    func updateIntSetting(setting: Setting, value: Int = 0) {
        setting.intValue = Int64(value)
        setting.objectWillChange.send()
        self.objectWillChange.send()
        PersistenceController.save()
    }
    
    func updateDateSetting(setting: Setting, value: Date? = Date()) {
        setting.dateValue = value
        setting.objectWillChange.send()
        self.objectWillChange.send()
        PersistenceController.save()
    }
    
    func updateStringSetting(setting: Setting, value: String = "") {
        setting.stringValue = value
        setting.objectWillChange.send()
        self.objectWillChange.send()
        PersistenceController.save()
    }
    
    func deleteSettingGroup(settingsGroup: SettingsGroup) {
        settingsGroup.delete()
    }
    
    func deleteSetting(setting: Setting) {
        setting.delete()
    }
    
    func deleteSettingGroup(key: String) {
        SettingsGroupDao.deleteSettingGroup(key: key)
    }
    
    func deleteSetting(key: String) {
        SettingDao.deleteSetting(key: key)
    }
}
