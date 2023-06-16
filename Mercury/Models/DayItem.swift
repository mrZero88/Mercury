//
//  DayItem.swift
//  Venus
//
//  Created by Daniel Correia on 04.12.22.
//

import Foundation

struct DayItem: Identifiable, Equatable {
    public var id: UUID = UUID()
    var dayOfTheWeek: Int
    var description: String
    var date: Date
    var isWeekDescription: Bool = false
    var isMonthDescription: Bool = false
}
