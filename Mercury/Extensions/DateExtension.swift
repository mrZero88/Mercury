//
//  DateExtension.swift
//  Moon
//
//  Created by Daniel Correia on 22.11.21.
//

import Foundation

extension Date {
    
    var yearMinDescription: String {
        get {
            return String(String(self.year).suffix(2))
        }
    }
    
    var monthMinDescriptionNumber: String {
        get {
            return self.month < 10 ? "0" + String(self.month) : String(self.month)
        }
    }
    
    var monthNameDescription: String {
        get {
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM"
            let name = nameFormatter.string(from: self)
            return name
        }
    }
    
    var halfYearDescription: String {
        get {
            if(self.month >= 1 && self.month <= 6) {
                return "1/2 " + String(self.year).suffix(2)
            } else {
                return "2/2 " + String(self.year).suffix(2)
            }
        }
    }
    
    var quarterDescription: String {
        get {
            if(self.month >= 1 && self.month <= 4) {
                return "Q1 " + String(self.year).suffix(2)
            } else if(self.month >= 5 && self.month <= 8) {
                return "Q2 " + String(self.year).suffix(2)
            } else {
                return "Q3 " + String(self.year).suffix(2)
            }
        }
    }
    
    var trimesterDescription: String {
        get {
            if(self.month >= 1 && self.month <= 3) {
                return "T1 " + String(self.year).suffix(2)
            } else if(self.month >= 4 && self.month <= 6) {
                return "T2 " + String(self.year).suffix(2)
            } else if(self.month >= 7 && self.month <= 9) {
                return "T3 " + String(self.year).suffix(2)
            } else {
                return "T4 " + String(self.year).suffix(2)
            }
        }
    }
    
    var isToday: Bool {
        get {
            return DateUtils.isSameDay(date1: self, date2: Date())
        }
    }
    
    var isThisWeek: Bool {
        get {
            return DateUtils.isSameWeek(date1: self, date2: Date())
        }
    }
    
    var isLastTwoWeeks: Bool {
        get {
            return DateUtils.isSameWeek(date1: self, date2: Date(), numberOfWeeks: 2)
        }
    }
    
    var isThisMonth: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date())
        }
    }
    
    var isLastTreeMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 3)
        }
    }
    
    var isLastFourMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 4)
        }
    }
    
    var isLastSixMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 6)
        }
    }
    
    var isThisYear: Bool {
        get {
            return DateUtils.isSameYear(date1: self, date2: Date())
        }
    }
    
    
    
    var isBeforeThenToday: Bool {
        get {
            return DateUtils.isBeforeDay(date1: self, date2: Date())
        }
    }
    
    var isBeforeThenThisWeek: Bool {
        get {
            return DateUtils.isBeforeWeek(date1: self, date2: Date())
        }
    }
    
    var isBeforeThenTwoWeeks: Bool {
        get {
            return DateUtils.isBeforeWeek(date1: self, date2: Date(), numberOfWeeks: 2)
        }
    }
    
    var isBeforeThenThisMonth: Bool {
        get {
            return DateUtils.isBeforeMonth(date1: self, date2: Date())
        }
    }
    
    var isBeforeThenThreeMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 3)
        }
    }
    
    var isBeforeThenFourMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 4)
        }
    }
    
    var isBeforeThenSixMonths: Bool {
        get {
            return DateUtils.isSameMonth(date1: self, date2: Date(), numberOfMonths: 6)
        }
    }
    
    var isBeforeThenThisYear: Bool {
        get {
            return DateUtils.isBeforeYear(date1: self, date2: Date())
        }
    }
    
    var dateWithCurrentTime: Date {
        get {
            let currentTime = Date()
            let dateCurrentTime = DateUtils.getDateOnCurrentTime(year: self.year, month: self.month, day: self.day, hour: currentTime.hour, minute: currentTime.minute, second: currentTime.second)
            return dateCurrentTime
        }
    }
    
    var weekMonthYearDescription: String {
        get {
            return "W" + String(self.weekNumber) + " " + DateUtils.formatDate(from: self, format: "MMMM").capitalizingFirstLetter().prefix(3) + " " + DateUtils.formatDate(from: self, format: "y").capitalizingFirstLetter().suffix(2)
        }
    }
    
    var weekYearDescription: String {
        get {
            return "W" + String(self.weekNumber) + " " + DateUtils.formatDate(from: self, format: "y").capitalizingFirstLetter()
        }
    }

    var monthYearDescription: String {
        get {
            return DateUtils.formatDate(from: self, format: "MMMM y").capitalizingFirstLetter()
        }
    }
    
    var year: Int {
        get {
            return Calendar.current.dateComponents([.year], from: self).year!
        }
    }
    
    var month: Int {
        get {
            return Calendar.current.dateComponents([.month], from: self).month!
        }
    }
    
    var day: Int {
        get {
            return Calendar.current.dateComponents([.day], from: self).day!
        }
    }
    
    var hour: Int {
        get {
            return Calendar.current.dateComponents([.hour], from: self).hour!
        }
    }
    
    var minute: Int {
        get {
            return Calendar.current.dateComponents([.minute], from: self).minute!
        }
    }
    
    var second: Int {
        get {
            return Calendar.current.dateComponents([.second], from: self).second!
        }
    }
    
    var weekNumber: Int {
        get {
            return Calendar.current.dateComponents([.weekOfYear], from: self).weekOfYear!
        }
    }
    
    var dayDate: Date? {
        get {
            return DateUtils.getDate(month: self.month, day: self.day, date: self)
        }
    }
    
    var localTimeZoneDateDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    var weekDayDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var weekDayLetter: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return String(dateFormatter.string(from: self).prefix(1)).uppercased()
    }
    
    var weekDays: [Date] {
        var dates: [Date] = []
        let startDate = self.startOfWeek().date
        let endDate = self.endOfWeek().date
        for date in stride(from: startDate, to: endDate, by: DateUtils.DAY_SECONDS) {
            dates.append(date.date)
        }
        return dates
    }
    
    var date: Date {
        get {
            return DateUtils.getDate(year: self.year, month: self.month, day: self.day)
        }
    }
    
    var dayOfTheWeek: Int {
        get {
            // Week starts on monday!
            var weekDay = Calendar.current.component(.weekday, from: self)
            
            switch(weekDay) {
            case 1: weekDay = 7
                break
            case 2: weekDay = 1
                break
            case 3: weekDay = 2
                break
            case 4: weekDay = 3
                break
            case 5: weekDay = 4
                break
            case 6: weekDay = 5
                break
            case 7: weekDay = 6
                break
            default:
                break
            }
            
            return weekDay
        }
    }
    
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
    
    func startOfWeek(numberOfWeeks: Int = 0) -> Date {
        var dateComponent = DateComponents()
        let weekDay = self.dayOfTheWeek
        dateComponent.day = -weekDay + 1
        let date = Calendar.current.date(byAdding: dateComponent, to: self)!
        return date.startOfDay()
    }
    
    func endOfWeek() -> Date {
        var dateComponent = DateComponents()
        let weekDay = self.dayOfTheWeek
        dateComponent.day = 7 - weekDay
        let date = Calendar.current.date(byAdding: dateComponent, to: self)!
        return date.endOfDay()
    }
    
    func startOfMonth(numberOfMonths: Int = 0) -> Date {
        var sOMDate = Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: Calendar.current.startOfDay(for: self)))!.startOfDay()
        for _ in 0..<numberOfMonths {
            sOMDate = DateUtils.addDate(date: self.date, days: -1)!
            sOMDate = sOMDate.startOfMonth()
        }
        return sOMDate
    }
    
    func endOfMonth() -> Date {
        return DateUtils.addDate(date: Calendar.current.date(byAdding: DateComponents(month: 1), to: self.startOfMonth())!.endOfDay(), days: -1)!
    }
    
    func startOfYear() -> Date {
        return DateUtils.getDate(year: self.year, month: 1, day: 1).startOfDay()
    }
    
    func endOfYear() -> Date {
        return DateUtils.getDate(year: self.year, month: 12, day: 31).endOfDay()
    }
    
    func startOfDay() -> Date {
        return DateUtils.getDate(year: self.year, month: self.month, day: self.day)
    }
    
    func endOfDay() -> Date {
        return DateUtils.getDate(year: self.year, month: self.month, day: self.day, hour: 23, minute: 59, second: 59)
    }
    
    func getLast(days: Int) -> [Date] {
        var dates: [Date] = []
        let startDate = DateUtils.addDate(date: self.date, days: -days)!.date
        let endDate = self.date
        for date in stride(from: startDate, to: endDate, by: DateUtils.DAY_SECONDS) {
            let datePlusOne = DateUtils.addDate(date: date, days: 1)!
            dates.append(datePlusOne)
        }
        return dates
    }
    
    func isInLast(days: Int) -> Bool {
        let date = DateUtils.addDate(date: Date().date, days: -(days-1))!
        if(self.date >= date) {
            return true
        }
        return false
    }
    
    func isSameDay(date: Date) -> Bool {
        return DateUtils.isSameDay(date1: self, date2: date)
    }
    
    func isSameWeek(date: Date) -> Bool {
        return DateUtils.isSameWeek(date1: self, date2: date)
    }
    
    func isSameMonth(date: Date, numberOfMonths: Int = 0) -> Bool {
        return DateUtils.isSameMonth(date1: self, date2: date, numberOfMonths: numberOfMonths)
    }
    
    func isSameYear(date: Date) -> Bool {
        return DateUtils.isSameYear(date1: self, date2: date)
    }
    
    func getMonthFirstDateByYear(by monthNumber: Int) -> Date {
        let date = DateUtils.getDate(year: self.year, month: monthNumber, day: 1)
        return date
    }
    
    func isOnOrAfterDay(date: Date) -> Bool {
        return (self.date >= date.date)
    }
    
    func isOnOrAfterWeek(date: Date) -> Bool {
        return (self.weekNumber >= date.weekNumber && self.year == date.year) || (self.year > date.year)
    }
    
    func isOnOrAfterMonth(date: Date) -> Bool {
        return (self.month >= date.month && self.year == date.year) || (self.year > date.year)
    }
    
    func isOnOrAfterYear(date: Date) -> Bool {
        return (self.year >= date.year)
    }
}
