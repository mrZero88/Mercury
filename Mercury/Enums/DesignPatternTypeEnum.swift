//
//  DesignPatternTypeEnum.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Foundation

enum DesignPatternType: String, Codable, Hashable {
    
    case Creational = "Creational"
    case Structural = "Structural"
    case Behavioral = "Behavioral"
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .Creational:
            hasher.combine(DesignPatternType.Creational)
        case .Structural:
            hasher.combine(DesignPatternType.Structural)
        case .Behavioral:
            hasher.combine(DesignPatternType.Behavioral)
            
        }
    }
    
    var description : String {
        switch self {
        case .Creational: return "Creational"
        case .Structural: return "Structural"
        case .Behavioral: return "Behavioral"
        }
    }
}
