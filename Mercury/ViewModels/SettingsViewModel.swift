//
//  SettingsController.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import Foundation
import Combine

public class SettingsViewModel: ObservableObject {
    @Published var settingGroups: [SettingsGroup] = []
    @Published var settingsController: SettingsController = SettingsController()
    
    var settings: [Setting] {
        get {
            return SettingDao.fetchSettings()
        }
    }
    
    init() {
        //DataUtils.wipeSettings(context: PersistenceController.shared.container.viewContext)
        //DataUtils.wipeSettingGroups(context: PersistenceController.shared.container.viewContext)
        let beginningDate = SettingsController.getDateValue(key: "firstOnDate")
        if(beginningDate == nil) {
            self.settingsController.addSettings()
        }
        settingGroups = SettingsGroupDao.fetchSettingGroups()
    }
    
    func fetchSettingGroups() {
        settingGroups = Array(SettingsGroupDao.fetchSettingGroups()[...1])
    }
}
