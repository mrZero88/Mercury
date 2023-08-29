//
//  Theme.swift
//  Alien
//
//  Created by Daniel Correia on 24.07.23.
//

import Foundation
import CoreData
import AVFoundation

@objc(Theme)
public class Theme: NSManagedObject, Encodable, Decodable {
    @objc private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required init(from decoder: Decoder) throws {
        super.init(entity: Theme.entity(), insertInto: PersistenceController.shared.container.viewContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decode(Date.self, forKey: .updatedAt)
        isActive = try values.decode(Bool.self, forKey: .isActive)
        iconName = try values.decode(String.self, forKey: .iconName)
        order = try values.decode(Int16.self, forKey: .order)
        text = try values.decode(String.self, forKey: .text)
        let topics = try values.decode([Topic].self, forKey: .topics)
        for topic in topics {
            self.addToTopics(topic)
        }
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case id,
             title,
             text,
             createdAt,
             updatedAt,
             isActive,
             iconName,
             order,
             topics
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(order, forKey: .order)
        try container.encode(self.activeTopics, forKey: .topics)
    }
    
}
