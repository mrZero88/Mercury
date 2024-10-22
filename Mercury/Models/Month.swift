//
//  Month.swift
//  Venus
//
//  Created by Daniel Correia on 08.12.22.
//

import Foundation

class Month: Hashable, Identifiable, ObservableObject, Equatable {
    
    public var id: UUID = UUID()
    var number: Int = 0
    var days: [DayItem] = []
    
    init(number: Int) {
        self.number = number
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        return lhs.id == rhs.id
    }    
}
