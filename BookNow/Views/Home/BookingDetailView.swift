//
//  BookingDetailView.swift
//  BookNow
//
//  Created by Karim Amsha on 2.06.2023.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI
import PopupView

struct BookingDetailView: View {
    var booking: Booking
    @State private var showingMap = false
    @State private var isCalendarVisible = false
    @State private var selectedDates: Set<Date> = []
    @Binding var isDetailActive: Bool

    var body: some View {
        //Get the booking item details
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    TabView {
                        ForEach(booking.bookingImages, id: \.self) { imageURL in
                            WebImage(url: URL(string: imageURL))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFill()
                                .frame(maxHeight: 360)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 360)
                    .padding(.top, d8)
                    
                    Button(action: {
                        withAnimation {
                            showingMap.toggle()
                        }
                    }) {
                        Image("ic_map")
                            .resizable()
                            .frame(width: d52, height: d52)
                    }
                    .padding(.trailing, d16)
                    .padding(.bottom, d22)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(booking.hotelName)
                        .customFont(weight: .semiBold, size: s22)
                        .foregroundColor(.black)

                    Text(booking.hotelLocation)
                        .customFont(weight: .regular, size: s17)
                        .foregroundColor(Color.gray3C3C43().opacity(0.60))
                        .lineLimit(2)
                        .padding(.top, d8)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: d16, height: d16)
                            .foregroundColor(Color.yellowFFA500())
                        Text(String(format: "%.1f", booking.rate))
                            .customFont(weight: .semiBold, size: s16)
                        Text("(\(String(format: "%.1f", booking.ratingCount)) reviews)")
                            .customFont(weight: .regular, size: s17)
                            .foregroundColor(Color.gray787878())
                    }
                    .padding(.top, d11)

                    Text(booking.aboutHotel)
                        .customFont(weight: .regular, size: s17)
                        .foregroundColor(Color.gray3C3C43())
                        .padding(.top, d24)

                    Text("\(booking.price)/Night")
                        .customFont(weight: .semiBold, size: s22)
                        .foregroundColor(.black)
                        .padding(.top, d24)

                    Text("Location")
                        .customFont(weight: .semiBold, size: s16)
                        .foregroundColor(.black)
                        .padding(.top, d34)

                    if showingMap {
                        // MapView to show the location, is showing when click map icon
                        MapView(latitude: booking.latitude, longitude: booking.longitude, customPinImage: UIImage(named: "ic_pin")!)
                            .frame(height: 215)
                            .padding(.top, d16)
                    }
                    
                    Button(action: {
                        // Handle "Book Now" button
                        isCalendarVisible.toggle()

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
                    .padding(.bottom, d16)
                    .padding(.top, d15)
                    
                    Spacer()
                }
                .padding(d16)
            }
            .popup(isPresented: $isCalendarVisible) {
                BookingCalendarView(isVisible: $isCalendarVisible, selectedDates: $selectedDates)
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .closeOnTap(false)
                    .backgroundColor(.clear)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            HStack {
                Button(action: {
                    isDetailActive.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text(booking.hotelName)
                    .customFont(weight: .semiBold, size: s17)
                    .foregroundColor(.black)
            },
            trailing:
                Button(action: {
                    // Perform action for option button
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundColor(.black)
                }
        )
    }
}

struct BookingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailView(booking: Booking(userPhoto: "user_photo_1", userName: "Alex Norman", location: "CA, United States.", latitude: 34.052235, longitude: -118.243683, bookingImages: ["https://imageio.forbes.com/specials-images/imageserve/5cdb058a5218470008b0b00f/Nobu-Ryokan-Malibu/0x0.jpg?format=jpg&height=1009&width=2000", "https://assets-global.website-files.com/5c6d6c45eaa55f57c6367749/624b471bdf247131f10ea14f_61d31b8dbff9b500cbd7ed32_types_of_rooms_in_a_5-star_hotel_2_optimized_optimized.jpeg", "https://www.claridges.co.uk/siteassets/rooms/2023-claridges-rooms-and-suites-balcony-room-1920_720.jpg"], bookingTitle: "Brunel's SS Great Britain", bookingDescription: "Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY", date: "25 Jan - 27 Jan", price: "$650", hotelName: "Hotel Huntington", aboutHotel: "A high quality renovation, with personal bathrooms, to welcome you in the heart of Lyon. On the mythical Croix Rousse hill, nice surprises to discover await you.", hotelLocation: "1200 E Huntington Dr,, Los Angeles County, California, Duarte, United States", rate: 4.9, ratingCount: 6.8), isDetailActive: .constant(false))
    }
}
