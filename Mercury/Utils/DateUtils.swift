//
//  DayUtils.swift
//  Moon
//
//  Created by Daniel Correia on 27.11.21.
//

import Foundation

public class DateUtils {
    
    public static let DAY_SECONDS: Double = 60*60*24
    public static let MINUTE_SECONDS: Int = 60
    
    public static func getFormatedWeek(currentDate: Date) -> String {
        return self.formatDate(from: currentDate.startOfWeek(), dateStyle: .short) + " - " + self.formatDate(from: currentDate.endOfWeek(), dateStyle: .short)
    }
    
    public static func getFormatedMonth(currentDate: Date) -> String {
        return self.formatDate(from: currentDate.startOfMonth(), dateStyle: .short) + " - " + self.formatDate(from: currentDate.endOfMonth(), dateStyle: .short)
    }
    
    public static func getFormatedYear(currentDate: Date) -> String {
        return self.formatDate(from: currentDate.startOfYear(), dateStyle: .short) + " - " + self.formatDate(from: currentDate.endOfYear(), dateStyle: .short)
    }
    
    public static func minutesToSeconds(minutes: Int64) -> Int64 {
        return minutes * 60
    }
    
    public static func hoursToSeconds(hours: Int64) -> Int64 {
        return hours * 60 * 60
    }
    
    public static func secondsToMinutes(seconds: Int64) -> Int64 {
        return (seconds % 3600) / 60
    }
    
    public static func secondsToHours(seconds: Int64) -> Int64 {
        return seconds / 3600
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int64) -> (Int64, Int64, Int64) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func formatTimeDiff(date1: Date, date2: Date) -> String {
        return formatSecondsInTime(seconds: getDatesDiff(date1: date1, date2: date2, component: .second))
    }
    
    static func formatSecondsInTime(seconds : Int64) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        let h = hours > 9 ? String(hours) : "0" + String(hours)
        let m = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let s = seconds > 9 ? String(seconds) : "0" + String(seconds)
        return h + ":" + m + ":" + s
    }
    
    static func formatSecondsInTime1(seconds : Int64) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let h = hours > 9 ? String(hours) : "0" + String(hours)
        let m = minutes > 9 ? String(minutes) : "0" + String(minutes)
        return h + ":" + m
    }
    
    static func formatSecondsInTime2(seconds : Int64) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        let m = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let s = seconds > 9 ? String(seconds) : "0" + String(seconds)
        return m + ":" + s
    }
    
    static func formatSecondsInTime3(seconds : Int64) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        let m = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let s = seconds > 9 ? String(seconds) : "0" + String(seconds)
        return m + ":" + s
    }
    
    public static func formatDate(from date: Date?, dateStyle: DateFormatter.Style = .long, timeStyle: DateFormatter.Style = .none) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return date != nil ? dateFormatter.string(from: date!) : ""
    }
    
    public static func formatDate(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let description = dateFormatter.string(from: date)
        return description
    }
    
    public static func getDatesDiff(date1: Date, date2: Date, component: Calendar.Component) -> Int64 {
        let diffs = Calendar.current.dateComponents([component], from: date1, to: date2)
        return Int64(diffs.value(for: component)!)
    }
    
    public static func getDateDiffSeconds(seconds: Int64, date: Date) -> Int64 {
        var dateComponent = DateComponents()
        dateComponent.second = -Int(seconds)
        let shorterDate =  Calendar.current.date(byAdding: dateComponent, to: date)!
        let diffs = Calendar.current.dateComponents([.second], from: shorterDate, to: date)
        return Int64(diffs.second!)
    }
    
    public static func dateDiffFormat(date1: Date, date2: Date?) -> String {
        if(date2 == nil) {
            return ""
        }
        
        let diffs = Calendar.current.dateComponents([.second], from: date1, to: date2!)
        let interval = DateUtils.formatSecondsInTime(seconds: Int64(diffs.second!))
        return interval
    }
    
    public static func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1.startOfDay(), to: date2.startOfDay())
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    public static func isSameWeek(date1: Date, date2: Date, numberOfWeeks: Int = 0) -> Bool {
        let diff = Calendar.current.dateComponents([.weekOfYear], from: date1.startOfWeek(), to: date2.startOfWeek())
        if diff.weekOfYear == numberOfWeeks {
            return true
        } else {
            return false
        }
    }
    
    public static func isSameMonth(date1: Date, date2: Date, numberOfMonths: Int = 0) -> Bool {
        let diff = Calendar.current.dateComponents([.month], from: date1.startOfMonth(), to: date2.startOfMonth())
        if diff.month == numberOfMonths {
            return true
        } else {
            return false
        }
    }
    
    public static func isSameYear(date1: Date, date2: Date) -> Bool {
        return date1.year == date2.year
    }
    
    public static func isBeforeDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1.startOfDay(), to: date2.startOfDay())
        if diff.day ?? 0 > 0 {
            return true
        } else {
            return false
        }
    }
    
    public static func isBeforeWeek(date1: Date, date2: Date, numberOfWeeks: Int = 0) -> Bool {
        let diff = Calendar.current.dateComponents([.weekOfYear], from: date1.startOfWeek(), to: date2.startOfWeek())
        if diff.weekOfYear ?? 0 > numberOfWeeks {
            return true
        } else {
            return false
        }
    }
    
    public static func isBeforeMonth(date1: Date, date2: Date, numberOfMonths: Int = 0) -> Bool {
        let diff = Calendar.current.dateComponents([.month], from: date1.startOfMonth(), to: date2.startOfMonth())
        if diff.month ?? 0 > numberOfMonths {
            return true
        } else {
            return false
        }
    }
    
    public static func isBeforeYear(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.year], from: date1.startOfYear(), to: date2.startOfYear())
        if diff.year ?? 0 > 0 {
            return true
        } else {
            return false
        }
    }
    
    public static func isEndOfWeek(date: Date) -> Bool {
        let lastDayOfWeek = date.endOfWeek()
        return DateUtils.isSameDay(date1: date, date2: lastDayOfWeek)
    }
    
    public static func addDate(date: Date, years: Int = 0, months: Int = 0, weeks: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        
        if(years == 0 && months == 0 && weeks == 0 && days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
            return nil
        }
        
        var dateComponent = DateComponents()
        dateComponent.year = years
        dateComponent.month = months
        dateComponent.weekOfYear = weeks
        dateComponent.day = days
        dateComponent.hour = hours
        dateComponent.minute = minutes
        dateComponent.second = seconds
        return Calendar.current.date(byAdding: dateComponent, to: date)
    }
    
    public static func monthDays(monthNumber: Int, date: Date) -> Int {
        var components = DateComponents()
        components.month = monthNumber
        components.year = Calendar.current.dateComponents([.year], from: date).year!
        let monthDate = Calendar.current.date(from: components)!
        var numberOfDays = Calendar.current.dateComponents([.day], from: monthDate.startOfMonth(), to: monthDate.endOfMonth()).day!
        
        if(monthNumber == 2)
        {
            numberOfDays = 29
        }
        
        return numberOfDays
    }
    
    public static func has29(date: Date) -> Bool {
        return monthDays(monthNumber: date.month, date: date) == 29
    }
    
    public static func hasDay(year: Int, month: Int, day: Int) -> Bool {
        var components = DateComponents()
        components.year = year
        components.month = month
        let monthDate = Calendar.current.date(from: components)!
        let numberOfDays = Calendar.current.dateComponents([.day], from: monthDate.startOfMonth(), to: monthDate.endOfMonth()).day!
        return day <= numberOfDays
    }
    
    public static func getDate(month: Int, day: Int, date: Date) -> Date? {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = Calendar.current.dateComponents([.year], from: date).year!
        
        if(day == 29 && month == 2 && !has29(date: date)) {
            return nil
        }
        
        return Calendar.current.date(from: components)!
    }
    
    public static func getDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)!
    }
    
    public static func getDateOnCurrentTime(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)!
    }
    
    public static func getDateDiffComponents(date1: Date, date2: Date?) -> DateComponents {
        return Calendar.current.dateComponents([.year,.month,.weekday,.day,.hour,.minute,.second], from: date1, to: date2 ?? date1)
    }
    
    public static func getTimeDiffDescription(diffs: DateComponents, shortForm: Bool = false) -> String {
        var numberOfComponents = 0
        let eYears = diffs.year ?? 0
        let eMonths = diffs.month ?? 0
        let eWeeks = diffs.weekOfYear ?? 0
        let eDays = diffs.day ?? 0
        let eHours = diffs.hour ?? 0
        let eMinutes = diffs.minute ?? 0
        let eSeconds = diffs.second ?? 0
        
        var result = ""
        
        if(eYears > 0 && numberOfComponents < 2) {
            let yearsDescription = shortForm ? "y" : (eYears == 1 ? String(localized: " Year") : String(localized: " Years"))
            result.append(String(eYears) + yearsDescription)
            numberOfComponents += 1
        }
        
        if(eMonths > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let monthsDescription = shortForm ? "M" : (eMonths == 1 ? String(localized: " Month") : String(localized: " Months"))
            result.append(String(eMonths) + monthsDescription)
            numberOfComponents += 1
        }
        
        if(eWeeks > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let weeksDescription = shortForm ? "w" : (eWeeks == 1 ? String(localized: " Week") : String(localized: " Weeks"))
            result.append(String(eWeeks) + weeksDescription)
            numberOfComponents += 1
        }
        
        if(eDays > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let daysDescription = shortForm ? "d" : (eDays == 1 ? String(localized: " Day") : String(localized: " Days"))
            result.append(String(eDays) + daysDescription)
            numberOfComponents += 1
        }
        
        if(eHours > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let hoursDescription = shortForm ? "h" : (eHours == 1 ? String(localized: " Hour") : String(localized: " Hours"))
            result.append(String(eHours) + hoursDescription)
            numberOfComponents += 1
        }
        
        if(eMinutes > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let minutesDescription = shortForm ? "m" : (eMinutes == 1 ? String(localized: " Minute") : String(localized: " Minutes"))
            result.append(String(eMinutes) + minutesDescription)
            numberOfComponents += 1
        }
        
        if(eSeconds > 0 && numberOfComponents < 2) {
            if(!result.isEmpty && !shortForm) {
                result = result.replacingOccurrences(of: " e", with: ",", options: .literal, range: nil)
                result.append(" e ")
            }
            let secondsDescription = shortForm ? "s" : (eSeconds == 1 ? String(localized: " Second") : String(localized: " Seconds"))
            result.append(String(eSeconds) + secondsDescription)
            numberOfComponents += 1
        }
        
        return result.isEmpty ? "0s" : result
    }
    
    static func getSecondsFromTime(inA date: Date) -> Int {
        return date.hour * 3600 + date.minute * 60 + date.second
    }
    
    static func convertSecondsToDateComponents(seconds: Int64) -> DateComponents {
        let now = Date()
        let futureDate = DateUtils.addDate(date: now, seconds: Int(seconds))
        return DateUtils.getDateDiffComponents(date1: now, date2: futureDate)
    }
    
    static func secondsDiffDesc(seconds: Int64) -> String {
        let now = Date()
        let futureDate = DateUtils.addDate(date: now, seconds: Int(seconds))
        let components = DateUtils.getDateDiffComponents(date1: now, date2: futureDate)
        return getTimeDiffDescription(diffs: components, shortForm: true)
    }
    
    static func isBeforeOrEqualTime(date1: Date, date2: Date) -> Bool {
        return date1.hour <= date2.hour && date1.minute <= date2.minute
    }
    
    static func isAfterTime(date1: Date, date2: Date) -> Bool {
        return getDate(year: date1.year, month: date1.month, day: date1.day, hour: date1.hour, minute: date1.minute) > getDate(year: date1.year, month: date1.month, day: date1.day, hour: date2.hour, minute: date2.minute)
    }
    
    static func getDatePlusTime(date: Date, seconds: Int) -> Date {
        return DateUtils.addDate(date: date.date, seconds: seconds)!
    }
}
