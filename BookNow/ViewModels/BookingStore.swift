//
//  BookingStore.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

class BookingStore: ObservableObject {
    @Published var bookings: [Booking]
    
    init() {
        bookings = [
            Booking(userPhoto: "user_photo_1", userName: "Alex Norman", location: "CA, United States.", latitude: 34.052235, longitude: -118.243683, bookingImages: ["https://imageio.forbes.com/specials-images/imageserve/5cdb058a5218470008b0b00f/Nobu-Ryokan-Malibu/0x0.jpg?format=jpg&height=1009&width=2000", "https://assets-global.website-files.com/5c6d6c45eaa55f57c6367749/624b471bdf247131f10ea14f_61d31b8dbff9b500cbd7ed32_types_of_rooms_in_a_5-star_hotel_2_optimized_optimized.jpeg", "https://www.claridges.co.uk/siteassets/rooms/2023-claridges-rooms-and-suites-balcony-room-1920_720.jpg"], bookingTitle: "Brunel's SS Great Britain", bookingDescription: "Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY", date: "25 Jan - 27 Jan", price: "$650", hotelName: "Hotel Huntington", aboutHotel: "A high quality renovation, with personal bathrooms, to welcome you in the heart of Lyon. On the mythical Croix Rousse hill, nice surprises to discover await you.", hotelLocation: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States", rate: 4.9, ratingCount: 6.8),
            Booking(userPhoto: "user_photo_2", userName: "Michealy Dam", location: "CA, United States.", latitude: 34.052235, longitude: -118.243683, bookingImages: ["https://imageio.forbes.com/specials-images/imageserve/5cdb058a5218470008b0b00f/Nobu-Ryokan-Malibu/0x0.jpg?format=jpg&height=1009&width=2000", "https://assets-global.website-files.com/5c6d6c45eaa55f57c6367749/624b471bdf247131f10ea14f_61d31b8dbff9b500cbd7ed32_types_of_rooms_in_a_5-star_hotel_2_optimized_optimized.jpeg", "https://www.claridges.co.uk/siteassets/rooms/2023-claridges-rooms-and-suites-balcony-room-1920_720.jpg"], bookingTitle: "Brunel's SS Great Britain", bookingDescription: "Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY", date: "25 Jan - 27 Jan", price: "$650", hotelName: "Hotel Huntington", aboutHotel: "A high quality renovation, with personal bathrooms, to welcome you in the heart of Lyon. On the mythical Croix Rousse hill, nice surprises to discover await you.", hotelLocation: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States", rate: 4.9, ratingCount: 6.8),
            Booking(userPhoto: "user_photo_1", userName: "John Doe", location: "CA, United States.", latitude: 34.052235, longitude: -118.243683, bookingImages: ["https://imageio.forbes.com/specials-images/imageserve/5cdb058a5218470008b0b00f/Nobu-Ryokan-Malibu/0x0.jpg?format=jpg&height=1009&width=2000", "https://assets-global.website-files.com/5c6d6c45eaa55f57c6367749/624b471bdf247131f10ea14f_61d31b8dbff9b500cbd7ed32_types_of_rooms_in_a_5-star_hotel_2_optimized_optimized.jpeg", "https://www.claridges.co.uk/siteassets/rooms/2023-claridges-rooms-and-suites-balcony-room-1920_720.jpg"], bookingTitle: "Brunel's SS Great Britain", bookingDescription: "Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY", date: "25 Jan - 27 Jan", price: "$650", hotelName: "Hotel Huntington", aboutHotel: "A high quality renovation, with personal bathrooms, to welcome you in the heart of Lyon. On the mythical Croix Rousse hill, nice surprises to discover await you.", hotelLocation: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States", rate: 4.9, ratingCount: 6.8),
        ]
    }
    
    func booking(_ item: Booking) {
        bookings.append(item)
    }
}
