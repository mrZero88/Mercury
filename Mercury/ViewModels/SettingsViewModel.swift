//
//  SettingsController.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import Foundation
import Combine

public class SettingsViewModel: ObservableObject {
    static var cancellables = Set<AnyCancellable>()
    @Published var settingGroups: [SettingsGroup] = []
    @Published var settingsController: SettingsController = SettingsController()
    
    var settings: [Setting] {
        get {
            return SettingDao.fetchAllSettings()
        }
    }
    
    func startConfigSettings() {
        let startUsingDate = SettingsController.getDateValue(key: "firstUse")
        if(startUsingDate == nil) {
            self.settingsController.addSettings()
            SetFirstUse(date: Date())
        }
        // SetFirstUse(date: DateUtils.getDate(year: 2023, month: 1, day: 1))
        SetLastUse(date: Date())
        self.fetchSettingGroups()
    }
    
    func fetchSettingGroups() {
        settingGroups = Array(SettingsGroupDao.fetchSettingGroups()[...1])
    }
}
