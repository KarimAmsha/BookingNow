//
//  CategoryItemView.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI

struct CategoryItemView: View {
    var item: String
    @Binding var selectedItem: String?

    var body: some View {
        //Category Item
        Button(action: {
            selectedItem = item
        }) {
            Text(item)
                .customFont(weight: .semiBold, size: s13)
                .padding(.horizontal, d16)
                .padding(.vertical, d10)
                .background(
                    Capsule()
                        .fill(selectedItem == item ? Color.primary() : Color.grayF2F2F7())
                )
                .foregroundColor(selectedItem == item ? .white : .black)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
