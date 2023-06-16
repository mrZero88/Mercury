//
//  Range.swift
//  Venus
//
//  Created by Daniel Correia on 02.10.22.
//

import Foundation

class Range: Hashable, Identifiable, ObservableObject, Equatable, CustomStringConvertible {
    
    public var id: UUID = UUID()
    var startDate: Date
    var endDate: Date
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Range, rhs: Range) -> Bool {
        return lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
    }
    
    public var description: String { return String(startDate.date.day) + "." + String(startDate.date.month) + "." + String(startDate.date.year) + ":" + String(startDate.hour) + ":" + String(startDate.minute) + "-" + String(endDate.date.day) + "." + String(endDate.date.month) + "." + String(endDate.date.year) + ":" + String(endDate.hour) + ":" + String(endDate.minute) }
}
