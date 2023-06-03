//
//  BookingRowView.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookingRowView: View {
    var booking: Booking
    @State private var isDetailActive = false

    var body: some View {
        //Booking item
        NavigationLink(destination: BookingDetailView(booking: booking, isDetailActive: $isDetailActive), isActive: $isDetailActive) {
        
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(booking.userPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: d48, height: d48)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(booking.userName)
                                .customFont(weight: .semiBold, size: s16)
                                .foregroundColor(.black)
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: d14, height: d14)
                                .foregroundColor(Color.primary())
                                .font(.title2)
                        }
                        Text(booking.location)
                            .customFont(weight: .regular, size: s15)
                            .foregroundColor(Color.gray3C3C43().opacity(0.60))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Perform action for option button
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                
                TabView {
                    ForEach(booking.bookingImages, id: \.self) { imageURL in
                        WebImage(url: URL(string: imageURL))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(maxHeight: 261)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
                .padding(.top, d14)

                Text(booking.bookingTitle)
                    .customFont(weight: .semiBold, size: s16)
                    .foregroundColor(.black)
                    .padding(.top, d12)

                Text(booking.bookingDescription)
                    .customFont(weight: .regular, size: s13)
                    .foregroundColor(Color.gray3C3C43().opacity(0.60))
                    .lineLimit(2)
                    .padding(.top, d4)

                Text(booking.date)
                    .customFont(weight: .regular, size: s13)
                    .foregroundColor(Color.gray3C3C43())
                    .padding(.top, 2)

                Text("\(booking.price)/Night")
                    .customFont(weight: .regular, size: s15)
                    .foregroundColor(.black)
                    .padding(.top, d4)
            }
            .buttonStyle(PlainButtonStyle()) 
            .padding(.horizontal, d16)
            .padding(.top, d16)
            .padding(.bottom, d12)
            .background(Color.white)
            .padding(.bottom, 4)
            .background(Color.grayF2F2F7())
            .onTapGesture {
                isDetailActive = true
            }
        }
    }
}
