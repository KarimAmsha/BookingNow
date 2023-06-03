//
//  HomeView.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var categoryViewModel = CategoryViewModel()
    @State private var selectedItem: String? = nil
    @StateObject var bookingStore = BookingStore()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer().frame(height: 55)
                
                //Get the top category
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categoryViewModel.items, id: \.self) { item in
                            CategoryItemView(item: item, selectedItem: $selectedItem)
                        }
                    }
                    .padding(.leading, d16)
                }
                
                Divider()
                    .background(Color.grayF2F2F7())

                //Get the booking list
                BookingListView(bookingStore: bookingStore)

                Spacer()
                Divider()

            }
            .edgesIgnoringSafeArea(.top)
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            selectedItem = categoryViewModel.items.first
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
