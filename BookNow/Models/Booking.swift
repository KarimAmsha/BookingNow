//
//  Booking.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

struct Booking: Identifiable {
    let id = UUID()
    let userPhoto: String
    let userName: String
    let location: String
    let latitude: Double
    let longitude: Double
    let bookingImages: [String]
    let bookingTitle: String
    let bookingDescription: String
    let date: String
    let price: String
    let hotelName: String
    let aboutHotel: String
    let hotelLocation: String
    let rate: Double
    let ratingCount: Double
}
