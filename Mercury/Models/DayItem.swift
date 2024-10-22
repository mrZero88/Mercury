//
//  DayItem.swift
//  Venus
//
//  Created by Daniel Correia on 04.12.22.
//

import Foundation

class DayItem: ObservableObject, Identifiable {
    public var id: UUID
    var dayOfTheWeek: Int
    var description: String
    var date: Date
    var isWeekDescription: Bool = false
    var isMonthDescription: Bool = false
    var count: Int16 = 0
    
    init(dayOfTheWeek: Int, description: String, date: Date, isWeekDescription: Bool = false, isMonthDescription: Bool = false, count: Int16 = 0) {
        self.id = UUID()
        self.dayOfTheWeek = dayOfTheWeek
        self.description = description
        self.date = date
        self.isWeekDescription = isWeekDescription
        self.isMonthDescription = isMonthDescription
        self.count = count
    }
}
