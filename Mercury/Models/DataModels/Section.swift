//
//  Section.swift
//  Mercury
//
//  Created by Daniel Correia on 29.08.23.
//

import Foundation
import CoreData
import AVFoundation

@objc(Section)
public class Section: NSManagedObject, Encodable, Decodable {
    @objc private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required init(from decoder: Decoder) throws {
        super.init(entity: Theme.entity(), insertInto: PersistenceController.shared.container.viewContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        text = try values.decode(String.self, forKey: .text)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        updatedAt = try values.decode(Date.self, forKey: .updatedAt)
        isActive = try values.decode(Bool.self, forKey: .isActive)
        order = try values.decode(Int16.self, forKey: .order)
        image = try values.decode(Data.self, forKey: .image)
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
             image
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(order, forKey: .order)
        try container.encode(image, forKey: .image)
    }
    
}
