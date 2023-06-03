//
//  CalendarViewModel.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var selectedDates: [Date] = []
//    @Published var selectedDates: Set<Date>?
    @Published var selectedStartDate: Date?
    @Published var selectedEndDate: Date?

    let calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
        
    func weekdaysAndDatesInCurrentMonth() -> (weekdays: [String], allDates: [Date]) {
        let currentMonth = calendar.dateComponents([.year, .month], from: Date())
        guard let startDateOfMonth = calendar.date(from: currentMonth),
              let endDateOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDateOfMonth) else {
            return ([], [])
        }
        
        let dateRange = calendar.range(of: .day, in: .month, for: startDateOfMonth)!
        let startDate = startDateOfMonth
        let endDate = calendar.date(byAdding: DateComponents(day: dateRange.count - 1), to: startDate)!
        
        var weekdays: [String] = []
        var allDates: [Date] = []
        var currentDate = startDate
        
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EE"
        
        while currentDate <= endDate {
            let weekday = weekdayFormatter.string(from: currentDate)
            if !weekdays.contains(weekday) {
                weekdays.append(weekday)
            }
            allDates.append(currentDate)
            currentDate = calendar.date(byAdding: DateComponents(day: 1), to: currentDate)!
        }
        
        return (weekdays, allDates)
    }

    func weekdaysInCurrentMonth() -> [String] {
        let currentMonth = calendar.dateComponents([.year, .month], from: Date())
        guard let startDateOfMonth = calendar.date(from: currentMonth),
              let endDateOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDateOfMonth) else {
            return []
        }
        
        guard let startDateOfWeek = calendar.date(bySetting: .weekday, value: 1, of: startDateOfMonth),
              let endDateOfWeek = calendar.date(bySetting: .weekday, value: 7, of: endDateOfMonth) else {
            return []
        }

        let dateRange = DateRange(startDate: startDateOfMonth, endDate: endDateOfMonth)

        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: startDateOfWeek)),
              let endDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: endDateOfWeek)) else {
            return []
        }

        let weekdays = calendar.range(of: .weekday, in: .weekOfMonth, for: startDate)
        
        guard let firstWeekday = weekdays?.lowerBound, let lastWeekday = weekdays?.upperBound else {
            return []
        }
        
        let weekdaySymbols = calendar.weekdaySymbols
        let weekdaySymbolsCount = weekdaySymbols.count
        
        var weekdayLabels: [String] = []
        var currentWeekday = firstWeekday
        
        while currentWeekday <= lastWeekday {
            let weekdayIndex = (currentWeekday - 1) % weekdaySymbolsCount
            weekdayLabels.append(weekdaySymbols[weekdayIndex])
            currentWeekday += 1
        }
        
        return weekdayLabels
    }

    func weeksInCurrentMonth() -> Binding<[[Date]]> {
        let currentMonth = calendar.dateComponents([.year, .month], from: Date())
        guard let startDateOfMonth = calendar.date(from: currentMonth),
              let endDateOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDateOfMonth) else {
            return .constant([])
        }
        
        guard let startDateOfWeek = calendar.date(bySetting: .weekday, value: 1, of: startDateOfMonth),
              let endDateOfWeek = calendar.date(bySetting: .weekday, value: 7, of: endDateOfMonth) else {
            return .constant([])
        }
        
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: startDateOfWeek)),
              let endDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: endDateOfWeek)) else {
            return .constant([])
        }
        
        let dateRange = DateRange(startDate: startDate, endDate: endDate)
        var weeks: [[Date]] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            let week = Array(dateRange.filter { calendar.isDate($0, equalTo: currentDate, toGranularity: .weekOfYear) })
            weeks.append(week)
            currentDate = calendar.date(byAdding: DateComponents(weekOfYear: 1), to: currentDate)!
        }
        
        return Binding<[[Date]]>(
            get: { weeks },
            set: { weeks = $0 }
        )
    }
}

struct DateRange: RandomAccessCollection {
    typealias Element = Date
    typealias Index = Int
    
    let startDate: Date
    let endDate: Date
    
    var startIndex: Int { 0 }
    var endIndex: Int { calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0 }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Date {
        return calendar.date(byAdding: DateComponents(day: position), to: startDate)!
    }
}

extension DateRange {
    private var calendar: Calendar {
        return Calendar.current
    }
}

extension CalendarViewModel {
    func setMissedDatesToSelectedDates(missedDates: [Date]) {
        selectedDates.append(contentsOf: missedDates.sorted(by: {$0 < $1}))
    }
    
    func removeDatesAfterSelectedDate(selectedDate: Date) {
        selectedDates = selectedDates.filter { $0 <= selectedDate }.sorted(by: {$0 < $1})
    }

    func getMissedDates() -> [Date] {
        guard let firstDate = selectedDates.sorted(by: {$0 < $1}).first,
              let lastDate = selectedDates.sorted(by: {$0 < $1}).last else {
            return []
        }
        
        var missedDates: [Date] = []
        var currentDate = firstDate
        
        while currentDate <= lastDate {
            if !selectedDates.contains(currentDate) {
                missedDates.append(currentDate)
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return missedDates.sorted(by: {$0 < $1})
    }
}
