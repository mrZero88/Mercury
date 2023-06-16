//
//  DateRangeUtils.swift
//  Venus
//
//  Created by Daniel Correia on 04.10.22.
//

import Foundation

public class DateRangeUtils {
    
    static func getDatesRange(startDate: Date, endDate: Date) -> [Date] {
        var dates: [Date] = []
        for date in stride(from: startDate.date, to: DateUtils.addDate(date: endDate.date, days: 1)!, by: DateUtils.DAY_SECONDS) {
            if(!dates.contains(where: {$0.year == date.year && $0.month == date.month && $0.day == date.day})) {
                dates.append(date)
            }
        }
        return dates
    }
    
    static func getDaysRange(startDate: Date, endDate: Date) -> [Range] {
        let daysPassed: Int = Int(DateUtils.getDatesDiff(date1: startDate.date, date2: endDate.date, component: .day))
        if(daysPassed < 0) {
            return []
        }
        var ranges: [Range] = []
        var currentDate = startDate
        for _ in 0...daysPassed {
            let firstDay = currentDate.startOfDay()
            let lastDay = firstDay.endOfDay()
            ranges.append(Range(startDate: firstDay, endDate: lastDay))
            currentDate = DateUtils.addDate(date: currentDate.date, days: 1)!
        }
        return ranges
    }
    
    static func getWeeksRange(startDate: Date, endDate: Date, separateWeeksBy: Int = 1) -> [Range] {
        let weeksPassed: Int = Int(DateUtils.getDatesDiff(date1: startDate.date, date2: endDate.date, component: .weekOfYear))
        if(weeksPassed < 0) {
            return []
        }
        
        var ranges: [Range] = []
        var resultRanges: [Range] = []
        var currentDate = startDate
        for _ in 0...weeksPassed {
            let firstDay = currentDate.startOfWeek()
            let lastDay = currentDate.endOfWeek()
            ranges.append(Range(startDate: firstDay, endDate: lastDay))
            currentDate = DateUtils.addDate(date: currentDate, weeks: 1)!
        }
        
        let weekChunks = chunkRange(ranges: ranges.reversed(), into: separateWeeksBy)
        
        for chunk in weekChunks {
            let range = Range(startDate: chunk.last!.startDate.startOfDay(), endDate: chunk.first!.endDate.endOfDay())
            resultRanges.append(range)
        }
        
        return resultRanges.reversed()
    }
    
    static func getMonthsRange(startDate: Date, endDate: Date, separateMonthsBy: Int = 1) -> [Range] {
        let monthsPassed: Int = Int(DateUtils.getDatesDiff(date1: startDate.date, date2: endDate.date, component: .month))
        if(monthsPassed < 0) {
            return []
        }
        
        var currentDate = startDate
        var ranges: [Range] = []
        var resultRanges: [Range] = []
        for _ in 0...monthsPassed {
            let firstDay = currentDate.startOfMonth()
            let lastDay = currentDate.endOfMonth()
            ranges.append(Range(startDate: firstDay, endDate: lastDay))
            currentDate = DateUtils.addDate(date: currentDate, months: 1)!
        }
        
        let monthChunks = chunkRange(ranges: ranges.reversed(), into: separateMonthsBy)
        
        for chunk in monthChunks {
            let range = Range(startDate: chunk.last!.startDate.startOfDay(), endDate: chunk.first!.endDate.endOfDay())
            resultRanges.append(range)
        }
        
        return resultRanges.reversed()
    }
    
    static func getYearsRange(startDate: Date, endDate: Date) -> [Range] {
        let yearsPassed: Int = Int(DateUtils.getDatesDiff(date1: startDate.date, date2: endDate.date, component: .year))
        if(yearsPassed < 0) {
            return []
        }
        var currentDate = startDate
        var ranges: [Range] = []
        
        for _ in 0...yearsPassed {
            let firstDay = currentDate.startOfYear()
            let lastDay = currentDate.endOfYear()
            ranges.append(Range(startDate: firstDay, endDate: lastDay))
            currentDate = DateUtils.addDate(date: currentDate, years: 1)!
        }
        
        return ranges
    }
    
    static func chunkRange(ranges: [Range], into size: Int) -> [[Range]] {
        if(size <= 0) {
            return []
        }
        var result: [[Range]] = []
        var group: [Range] = []
        var i = 1
        for range in ranges {
            group.append(range)
            if(i == size) {
                result.append(group)
                group = []
                i = 0
            }
            i += 1
        }
        return result
    }
}
