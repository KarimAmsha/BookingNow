//
//  CategoryViewModel.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var items = ["Already Booked", "Looking for Partner", "Rented Rooms"]
}
