//
//  SSettingExtension.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation

extension Setting {
    func delete() {
        self.isActive = false
        self.updatedAt = Date()
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
}
