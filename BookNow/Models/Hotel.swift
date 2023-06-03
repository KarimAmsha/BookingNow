//
//  Hotel.swift
//  BookNow
//
//  Created by Karim Amsha on 3.06.2023.
//

import SwiftUI

struct Hotel: Identifiable {
    let id = UUID()
    let name: String
    let images: [String]
    let aboutHotel: String
    let location: String
    let latitude: Double
    let longitude: Double
    let rate: Double
    let ratingCount: Double
}
