//
//  BookingCalendarView.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

struct BookingCalendarView: View {
    @Binding var isVisible: Bool
    @Binding var selectedDates: Set<Date>
    @State private var adultsCount = 1
    @State private var childrenCount = 0
    @StateObject var calendarViewModel = CalendarViewModel()
    @StateObject var bookingStore = BookingStore()
    let endDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()

    init(isVisible: Binding<Bool>, selectedDates: Binding<Set<Date>>) {
        self._isVisible = isVisible
        self._selectedDates = selectedDates
    }

    var body: some View {
        // Calender view
        HStack(alignment: .top, spacing: 16) {
            VStack {
                HStack {
                    if let fromDate = calendarViewModel.selectedDates.sorted(by: {$0 < $1}).first, let toDate = calendarViewModel.selectedDates.sorted(by: {$0 < $1}).last {
                        HStack {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: d4, height: d7)
                                .foregroundColor(.black)
                            Text("\(formattedDate(fromDate)) - \(formattedDate(toDate)), \(formattedYear(fromDate))")
                                .customFont(weight: .displaySemiBold, size: d20)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: d4, height: d7)
                                .foregroundColor(.black)
                        }
                    }

                    Spacer()
                    Button(action: {
                        withAnimation {
                            isVisible.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.grayF2F2F7())
                                .frame(width: d30, height: d30)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: d10, height: d10)
                                .foregroundColor(Color.gray3C3C43())
                        }
                    }
                    .padding(.horizontal, d6)
                }
                
                // This code for another solution using FSCalender library
//                VStack {
//                    CalendarView(selectedDates: $selectedDates, fromDate: $fromDate, toDate: $toDate)
//                        .frame(height: 250)
//                }

                // This code for handling custome calender
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: calendarViewModel.weekdaysAndDatesInCurrentMonth().weekdays.count), spacing: 0) {
                    ForEach(calendarViewModel.weekdaysAndDatesInCurrentMonth().weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .customFont(weight: .semiBold, size: s13)
                            .frame(maxWidth: .infinity, maxHeight: d48)
                            .foregroundColor(.gray3C3C43().opacity(0.30))
                            .padding(.top, d22)
                    }
                    
                    ForEach(calendarViewModel.weekdaysAndDatesInCurrentMonth().allDates, id: \.self) { date in
                        Text("\(calendarViewModel.calendar.component(.day, from: date))")
                            .customFont(weight: .displayRegular, size: s20)
                            .frame(maxWidth: .infinity, maxHeight: d48)
                            .padding(d12)
                            .onTapGesture {
                                let endDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                                if date < endDate {
                                    return
                                }
                                if calendarViewModel.selectedDates.contains(date) {
                                    calendarViewModel.selectedDates.removeAll { $0 == date }
                                    calendarViewModel.removeDatesAfterSelectedDate(selectedDate: date)
                                } else {
                                    calendarViewModel.selectedDates.append(date)
                                    let missedDates = calendarViewModel.getMissedDates()
                                    calendarViewModel.setMissedDatesToSelectedDates(missedDates: missedDates)
                                }
                            }
                            .foregroundColor(date < endDate ? .gray3C3C43().opacity(0.30) : calendarViewModel.selectedDates.sorted(by: {$0 < $1}).contains(date) ? .white : .black)
                            .background(calendarViewModel.selectedDates.sorted(by: {$0 < $1}).contains(date) ? Color.primary() : Color.white)
                            .cornerRadius(calendarViewModel.selectedDates.sorted(by: {$0 < $1}).count == 1 ? d8 : calendarViewModel.selectedDates.sorted(by: {$0 < $1}).first == date ? d8 : calendarViewModel.selectedDates.sorted(by: {$0 < $1}).last == date ? d8 : 0, corners: calendarViewModel.selectedDates.sorted(by: {$0 < $1}).count == 1 ? [.topLeft, .topRight, .bottomLeft, .bottomRight] : calendarViewModel.selectedDates.sorted(by: {$0 < $1}).first == date ? [.topLeft, .bottomLeft] : calendarViewModel.selectedDates.sorted(by: {$0 < $1}).last == date ? [.topRight, .bottomRight] : [])
                            .padding(.top, d8)
                    }
                }

                VStack(spacing: d16) {
                    // Clear booking selection
                    HStack {
                        Text("Guests")
                            .customFont(weight: .semiBold, size: s16)
                        Spacer()
                        Button {
                            calendarViewModel.selectedDates.removeAll()
                            adultsCount = 1
                            childrenCount = 0
                        } label: {
                            Text("Clear")
                                .customFont(weight: .regular, size: s16)
                        }
                        .foregroundColor(.primary())
                    }
                    
                    Divider()
                    
                    // Adults
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Adults")
                                .customFont(weight: .regular, size: s14)
                            Text("after 18")
                                .customFont(weight: .regular, size: s12)
                                .foregroundColor(.gray3C3C43().opacity(0.6))
                        }
                        Spacer()
                        HStack {
                            Button {
                                if adultsCount > 1 {
                                    adultsCount -= 1
                                }
                            } label: {
                                Text("-")
                            }
                            Text(adultsCount.toString)
                            Button {
                                adultsCount += 1
                            } label: {
                                Text("+")
                            }
                        }
                        .foregroundColor(.black)
                        .customFont(weight: .regular, size: s16)
                    }
                    
                    Divider()

                    // Children's
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Children's")
                                .customFont(weight: .regular, size: s14)
                            Text("0 - 12 years")
                                .customFont(weight: .regular, size: s12)
                                .foregroundColor(.gray3C3C43().opacity(0.6))
                        }
                        Spacer()
                        HStack {
                            Button {
                                if childrenCount > 0 {
                                    childrenCount -= 1
                                }
                            } label: {
                                Text("-")
                            }
                            Text(childrenCount.toString)
                            Button {
                                childrenCount += 1
                            } label: {
                                Text("+")
                            }
                        }
                        .foregroundColor(.black)
                        .customFont(weight: .regular, size: s16)
                    }
                    
                    Divider()
                }
                .padding(.top, d44)
                
                Button(action: {
                    // Handle "Book Now" button
//                    bookingStore.booking(<#T##Booking#>)
                     isVisible.toggle()
                }) {
                    HStack(spacing: d11) {
                        Image("ic_book")
                            .resizable()
                            .frame(width: d18, height: d18)

                        Text("Book Now")
                            .customFont(weight: .semiBold, size: s17)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, d15)
                    .foregroundColor(.white)
                    .background(Color.primary())
                    .clipShape(Capsule())
                }
                .padding(.top, d16)
            }
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: d26, leading: d16, bottom: d22, trailing: d16))
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(d30, corners: [.topLeft, .topRight])
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date)
    }
    
    private func formattedYear(_ date: Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
}

struct BookingCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        BookingCalendarView(isVisible: .constant(false), selectedDates: .constant([]))
    }
}
