//
//  CalendarView.swift
//  BookNow
//
//  Created by Karim Amsha on 3.06.2023.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    @Binding var selectedDates: [Date]
    @Binding var fromDate: Date?
    @Binding var toDate: Date?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.allowsMultipleSelection = true
        calendar.appearance.weekdayTextColor = UIColor(Color.gray3C3C43()).withAlphaComponent(0.30)
        calendar.calendarHeaderView.isHidden = true
        calendar.headerHeight = 0
        calendar.appearance.titleFont = UIFont(name: "SF-UI-Display-Regular", size: 20)

        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, FSCalendarDelegate {
        var parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDates.append(date)
            updateSelectedDateRange()
        }
        
        func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            if let index = parent.selectedDates.firstIndex(of: date) {
                parent.selectedDates.remove(at: index)
            }
            updateSelectedDateRange()
        }
        
        private func updateSelectedDateRange() {
            if parent.selectedDates.isEmpty {
                parent.fromDate = nil
                parent.toDate = nil
            } else {
                parent.fromDate = parent.selectedDates.min()
                parent.toDate = parent.selectedDates.max()
            }
        }
    }
}
