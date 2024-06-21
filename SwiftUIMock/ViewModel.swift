//
//  ViewModel.swift
//  Created by GaliSrikanth on 04/06/24.

import Foundation

class ViewModel: ObservableObject {
    var currentDate: Date {
        didSet {
            loadDates()
        }
    }
    var showFullCalendar: Bool = false {
        didSet {
            let currentDateTest = currentDate
            currentDate = currentDateTest
        }
    }
    
    @Published var dates: [Date]!  = []
    @Published var monthTitle: String  = ""
    @Published var disableBackBtn: Bool  = false
    
    init() {
        currentDate = Date()
        loadDates()
    }
    
    private func loadDates() {
        if showFullCalendar {
            loadFullMonth(ForDate: currentDate)
        } else {
            loadOnly1Week(ForDate: currentDate)
        }
        
        updateCalendarHeaderValues()
    }
    
    private func updateCalendarHeaderValues() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        monthTitle = dateFormatter.string(from: currentDate)
        
        
        
        if showFullCalendar {
         
        } else {
            let calendar: Calendar = Calendar.current
            let updatedCurrentDate = (calendar.date(byAdding: .day, value: -7, to: currentDate) ?? Date()).dateWithMonthAndYear()
            if let todayStartOfWeek = Date().dateWithMonthAndYear().startOfWeek() {
                if updatedCurrentDate < todayStartOfWeek {
                    disableBackBtn = true
                } else {
                    disableBackBtn = false
                }
            } else {
                disableBackBtn = false
            }
        }
    }
    
    private func loadOnly1Week(ForDate dateIs: Date) {
        var currentDateStartOfTheWeek: Date!
        var currentDateEndOfTheWeek: Date!
        let today = dateIs
        if let startOfWeek = today.startOfWeek(),
           let endOfWeek = today.endOfWeek() {
            currentDateStartOfTheWeek = startOfWeek
            currentDateEndOfTheWeek = endOfWeek
            
            dates = DateManager.datesUntil(WithStartDate: currentDateStartOfTheWeek,
                                                 WithEndDate: currentDateEndOfTheWeek)
        }
    }
    
    private func loadFullMonth(ForDate dateIs: Date) {
        var currentDateStartOfTheWeek: Date!
        var monthEndDateEndOfTheWeek: Date!
        
        let startDayOfMonth = DateManager.getStartAndEndOfMonth(for: Date()).0
        let endDayOfMonth = DateManager.getStartAndEndOfMonth(for: Date()).1
        let tempCurrentDate = currentDate.dateWithMonthAndYear()
        if (tempCurrentDate >= startDayOfMonth) && (tempCurrentDate <= endDayOfMonth) {
            if let startOfWeek = Date().startOfWeek() {
                currentDateStartOfTheWeek = startOfWeek
                disableBackBtn = true
            }
        } else {
            let startDayOfMonth1 = DateManager.getStartAndEndOfMonth(for: tempCurrentDate).0
            currentDateStartOfTheWeek = startDayOfMonth1.startOfWeek()
            disableBackBtn = false
        }
        
        
        
        
        if let lastDayOfMonth = dateIs.endOfMonth() {
            if let endOfWeek = lastDayOfMonth.endOfWeek() {
                monthEndDateEndOfTheWeek = endOfWeek
            }
        }
        
        if let currentDateStartOfTheWeek = currentDateStartOfTheWeek, let monthEndDateEndOfTheWeek = monthEndDateEndOfTheWeek {
//            let allDays = DateManager.datesUntil(WithStartDate: currentDateStartOfTheWeek, WithEndDate: monthEndDateEndOfTheWeek)
            dates = DateManager.datesUntil(WithStartDate: currentDateStartOfTheWeek,
                                                 WithEndDate: monthEndDateEndOfTheWeek)
        }
    }
    
    func leftArrowClicked() {
        print("left clicked")
        if showFullCalendar == false {
            let calendar: Calendar = Calendar.current
            let tempCurrentDate = (calendar.date(byAdding: .day, value: -7, to: currentDate) ?? Date()).dateWithMonthAndYear()
            let today = (Date().startOfWeek() ?? Date()).dateWithMonthAndYear()
            
            if tempCurrentDate >= today {
                currentDate = tempCurrentDate
            } else {
                print("Cannot go back")
            }
        } else {
            let calendar: Calendar = Calendar.current
            if let tempCurrentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
                print(tempCurrentDate)
                currentDate = tempCurrentDate
            }
        }
    }
    
    func rightArrowClicked() {
        print("right clicked")
        if showFullCalendar == false {
            let calendar: Calendar = Calendar.current
            if let tempCurrentDate = calendar.date(byAdding: .day, value: 7, to: currentDate) {
                currentDate = tempCurrentDate
            }
        } else {
            let calendar: Calendar = Calendar.current
            if let tempCurrentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
                print(tempCurrentDate)
                currentDate = tempCurrentDate
            }
        }
    }
}
