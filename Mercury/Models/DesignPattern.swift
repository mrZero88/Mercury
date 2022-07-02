//
//  DesignPattern.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Foundation

struct DesignPattern: Codable, Hashable, Identifiable {
    var id: Int
    let name: String
    let classDiagramImageName: String
    let definition: String
    let type: DesignPatternType
    let concept: InfoItem
    let realWorldExample: InfoItem
    let computerWorldExample: InfoItem
    let illustration: InfoItem
    let discussion: InfoItem
    let pros: [String]
    let cons: [String]
}
