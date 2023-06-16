//
//  MonthUtils.swift
//  Venus
//
//  Created by Daniel Correia on 04.12.22.
//

import Foundation

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
    
    static func getMonthsAfterStart() -> [Month] {
        return months.filter({Date().getMonthFirstDateByYear(by: $0.number) >= BeginningDate.startOfYear() && $0.number <= Date().month})
    }
    
    static func getMonth(by date: Date) -> [DayItem] {
        let startDate = date.startOfMonth()
        let endDate = date.endOfMonth()
        let daysRange = DateRangeUtils.getDaysRange(startDate: startDate, endDate: endDate)
        
        var days: [DayItem] = []
        
        for day in daysRange {
            days.append(DayItem(dayOfTheWeek: 1, description: String(day.startDate.day), date: day.startDate.date))
        }
        
        return days
    }
    
    static func addSixtEmptyWeek(days: inout [DayItem], date: Date) {
        let numberOfLines = days.chunked(into: 7).count
        if(numberOfLines == 6) {
            days.append(DayItem(dayOfTheWeek: 1, description: "", date: date.endOfMonth()))
        }
        let lastChunk = days.chunked(into: 7).last!
        let lastChunkCount = lastChunk.count
        if(lastChunkCount < 7) {
            let size = 7 - lastChunkCount
            for i in 1...size {
                days.append(DayItem(dayOfTheWeek: (i+1), description: "", date: date.endOfMonth()))
            }
        }
    }
    
    static func addMonthMinDescription(days: inout [DayItem], monthDescription: String) {
        let daysCount = days.count
        let monthLetters = monthDescription.prefix(3)
        
        let firstChar: String = String(Array(monthLetters)[0])
        let secondChar: String = String(Array(monthLetters)[1])
        let thirdChar: String = String(Array(monthLetters)[2])
        
        days[daysCount-3].description = firstChar
        days[daysCount-3].isMonthDescription = true
        days[daysCount-2].description = secondChar
        days[daysCount-2].isMonthDescription = true
        days[daysCount-1].description = thirdChar
        days[daysCount-1].isMonthDescription = true
        
    }
}
