//
//  SSettingExtension.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation

extension Setting: Encodable {
    func delete() {
        self.updatedAt = Date()
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    func activate() {
        self.updatedAt = Date()
        PersistenceController.save()
    }
    func deactivate() {
        self.updatedAt = Date()
        PersistenceController.save()
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case id,
             key,
             title,
             dataType,
             boolValue,
             intValue,
             dateValue,
             stringValue,
             uuidValue,
             createdAt,
             updatedAt,
             group,
             order,
             type,
             enabled,
             isVisible,
             doubleValue,
             minDouble,
             maxDouble,
             independent
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(key, forKey: .key)
        try container.encode(title, forKey: .title)
        try container.encode(dataType, forKey: .dataType)
        try container.encode(boolValue, forKey: .boolValue)
        try container.encode(intValue, forKey: .intValue)
        try container.encode(dateValue, forKey: .dateValue)
        try container.encode(stringValue, forKey: .stringValue)
        try container.encode(uuidValue, forKey: .uuidValue)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(group, forKey: .group)
        try container.encode(order, forKey: .order)
        try container.encode(type, forKey: .type)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(doubleValue, forKey: .doubleValue)
        try container.encode(minDouble, forKey: .minDouble)
        try container.encode(maxDouble, forKey: .maxDouble)
        try container.encode(independent, forKey: .independent)
    }
}
