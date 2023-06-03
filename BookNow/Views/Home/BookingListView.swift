//
//  BookingListView.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

struct BookingListView: View {
    @ObservedObject var bookingStore: BookingStore
    
    var body: some View {
        //Booking list
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(bookingStore.bookings) { booking in
                    BookingRowView(booking: booking)
                }
            }
        }
    }
}
