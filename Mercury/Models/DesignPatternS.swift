//
//  DesignPatternS.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

struct DesignPatternS: Codable, Hashable, Identifiable {
    var id: Int
    let title: String
    let text1: String
    let text2: String
    let type: String
    let image: String
    let concept: InfoItem
    let realWorldExample: InfoItem
    let computerWorldExample: InfoItem
    let illustration: InfoItem
    let discussion: InfoItem
    let pros: [String]
    let cons: [String]
}
