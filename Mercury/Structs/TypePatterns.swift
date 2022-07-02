//
//  TypePatterns.swift
//  Mercury
//
//  Created by Daniel Correia on 28.06.22.
//

import Foundation

struct TypePatterns: Hashable, Identifiable {
    var id: UUID = UUID()
    var type: DesignPatternType
    var patterns: [DesignPattern] = []
}
