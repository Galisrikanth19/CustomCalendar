//
//  DateManager.swift
//  Created by GaliSrikanth on 04/06/24.

import Foundation

class DateManager {
    static func datesUntil(WithStartDate startDate: Date, WithEndDate endDate: Date, using calendar: Calendar = Calendar.current) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }
        
        return dates
    }
    
    static func getStartAndEndOfMonth(for date: Date) -> (startDate: Date, endDate: Date) {
      let calendar = Calendar.current

      // Get the year and month components from the date
      let year = calendar.component(.year, from: date)
      let month = calendar.component(.month, from: date)

      // Create a new date object for the first day of the month
      let startDate = calendar.date(from: DateComponents(year: year, month: month, day: 1))!

      // Get the number of days in the month
      let range = calendar.range(of: .day, in: .month, for: date)
      let numDays = range!.count

      // Create a new date object for the last day of the month
      let endDate = calendar.date(from: DateComponents(year: year, month: month, day: numDays))!

      return (startDate, endDate)
    }

}

extension Date {
    func startOfWeek(using calendar: Calendar = Calendar.current) -> Date? {
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.weekday = calendar.firstWeekday
        return calendar.date(from: components)
    }
    
    func endOfWeek(using calendar: Calendar = Calendar.current) -> Date? {
        let currentWeekday = calendar.component(.weekday, from: self)
        let daysToEndOfWeek = calendar.weekdaySymbols.count - currentWeekday
        return calendar.date(byAdding: .day, value: daysToEndOfWeek, to: self)
    }
    
    func endOfMonth(using calendar: Calendar = Calendar.current) -> Date? {
        var components = calendar.dateComponents([.year, .month], from: self)
        components.month! += 1
        components.day = 1
        guard let startOfNextMonth = calendar.date(from: components) else {
            return nil
        }
        // Subtract one day to get the last day of the current month
        return calendar.date(byAdding: .day, value: -1, to: startOfNextMonth)
    }
    
    func dateWithMonthAndYear(using calendar: Calendar = Calendar.current) -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return (calendar.date(from: components) ?? Date())
    }
}
