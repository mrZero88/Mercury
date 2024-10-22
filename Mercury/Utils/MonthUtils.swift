//
//  MonthUtils.swift
//  Venus
//
//  Created by Daniel Correia on 04.12.22.
//

import Foundation
import Utils

public class MonthUtils {
    
    static let months: [Month] = [
        Month(number: 1),
        Month(number: 2),
        Month(number: 3),
        Month(number: 4),
        Month(number: 5),
        Month(number: 6),
        Month(number: 7),
        Month(number: 8),
        Month(number: 9),
        Month(number: 10),
        Month(number: 11),
        Month(number: 12),
    ]
    
    static func getMonthsAfterStart(viewModel: ViewModel) -> [Month] {
        let months = months.filter({Date().getMonthFirstDateByYear(by: $0.number) >= FirstOnDate.startOfYear() && $0.number <= Date().month})
        
        for month in months {
            month.days = getMonth(viewModel: viewModel, year: Date().year, monthNumber: month.number)
        }
        
        return months
    }
    
    static func getMonth(viewModel: ViewModel, year: Int, monthNumber: Int) -> [DayItem] {
        let date = DateUtils.getDate(year: year, month: monthNumber, day: 1)
        let startDate = date
        let endDate = date.endOfMonth()
        let daysRange = DateRangeUtils.getDaysRange(startDate: startDate, endDate: endDate)
        let count: Int16 = 0
        
        var days: [DayItem] = []
        
        for day in daysRange {
            days.append(DayItem(dayOfTheWeek: 1, description: String(day.startDate.day), date: day.startDate.date, count: count))
        }
        
        return days
    }
    
    static func addCountToDayItemByDate(months: [Month], date: Date) {
        let month = months.first(where: {$0.number == date.month})!
        let day = month.days.first(where: {$0.date.date == date.date})!
        day.count += 1
        day.objectWillChange.send()
    }
    
    static func subtractCountToDayItemByDate(months: [Month], date: Date) {
        let month = months.first(where: {$0.number == date.month})!
        let day = month.days.first(where: {$0.date.date == date.date})!
        day.count -= day.count > 0 ? 1 : 0
        day.objectWillChange.send()
    }
}
