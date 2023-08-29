//
//  Topic.swift
//  Mercury
//
//  Created by Daniel Correia on 29.08.23.
//

import Foundation
import CoreData
import AVFoundation

@objc(Topic)
public class Topic: NSManagedObject, Encodable, Decodable {
    @objc private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required init(from decoder: Decoder) throws {
        super.init(entity: Theme.entity(), insertInto: PersistenceController.shared.container.viewContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        text = try values.decode(String.self, forKey: .text)
        subtitle = try values.decode(String.self, forKey: .subtitle)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decode(Date.self, forKey: .updatedAt)
        isActive = try values.decode(Bool.self, forKey: .isActive)
        iconName = try values.decode(String.self, forKey: .iconName)
        order = try values.decode(Int16.self, forKey: .order)
        
        let sections = try values.decode([Section].self, forKey: .sections)
        for section in sections {
            self.addToSections(section)
        }
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case id,
             title,
             text,
             subtitle,
             createdAt,
             updatedAt,
             isActive,
             iconName,
             order,
             sections
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(order, forKey: .order)
        try container.encode(self.activeSections, forKey: .sections)
    }
    
}
