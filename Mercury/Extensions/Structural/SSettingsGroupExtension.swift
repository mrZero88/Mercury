//
//  SSettingsGroupExtension.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation

extension SettingsGroup: Encodable {
    func delete() {
        PersistenceController.delete(object: self)
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
    
    private enum CodingKeys: String, CodingKey
    {
        case id,
             key,
             title,
             iconName,
             order,
             createdAt,
             updatedAt
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(key, forKey: .key)
        try container.encode(title, forKey: .title)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(order, forKey: .order)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
