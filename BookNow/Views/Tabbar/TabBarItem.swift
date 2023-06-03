//
//  TabBarItem.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

struct TabBarItem: View {
    let img: String
    let title: String
    let index: Int
    @Binding var selection: Int
    
    var body: some View {
        // TabBar item
        VStack(spacing: 4) {
            Image(img)
                .font(.title)
            Text(title)
                .font(.caption)
        }
        .foregroundColor(selection == index ? Color.primary() : .black)
        .padding(.top, 6)
        .onTapGesture {
            selection = index
        }
    }
}

