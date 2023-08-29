//
//  AlienData.swift
//  Alien
//
//  Created by Daniel Correia on 21.07.23.
//

import Foundation

struct MercuryData: Encodable, Decodable {
    let themes: [Theme]
    
    private enum CodingKeys: String, CodingKey
    {
        case themes
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(themes, forKey: .themes)
    }
    
    init(themes: [Theme]) {
        self.themes = themes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        themes = try values.decode([Theme].self, forKey: .themes)
    }
    
}
