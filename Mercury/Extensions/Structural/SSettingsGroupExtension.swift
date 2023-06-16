//
//  SSettingsGroupExtension.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation

extension SettingsGroup {
    func delete() {
        self.isActive = false
        self.updatedAt = Date()
        self.deleteSettings()
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    func activate() {
        self.isActive = true
        self.updatedAt = Date()
        PersistenceController.save()
    }
    func deactivate() {
        self.isActive = false
        self.updatedAt = Date()
        PersistenceController.save()
    }
    func deleteSettings() {
        for setting in self.allSettings {
            setting.delete()
        }
    }
    var allSettings: [Setting] {
        get {
            return SettingsUtils.settings(set: self.settings)
        }
    }
    var activeSettings: [Setting] {
        get {
            return SettingsUtils.settings(set: self.settings).filter({$0.isActive})
        }
    }
}
