//
//  MainView.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI
import UIKit

struct MainView: View {
    @State private var selection = 0
    @EnvironmentObject var appState: AppState
    @State var tabBarHeight = 0.0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView(selection: $selection) {
                    // Home Tab
                    HomeView()
                        .tabItem {
//                            Divider()
                            TabBarItem(img: "ic_home", title: "", index: 0, selection: $selection)
                        }
                        .tag(0)
                    
                    // Confirmation Tab
                    ConfirmationView()
                        .tabItem {
                            TabBarItem(img: "ic_confirmation", title: "", index: 1, selection: $selection)
                        }
                        .tag(1)
                    
                    // Notification Tab
                    NotificationsView()
                        .tabItem {
                            TabBarItem(img: "ic_bell", title: "", index: 2, selection: $selection)
                        }
                        .tag(2)
                    
                    // Profile Tab
                    ProfileView()
                        .tabItem {
                            TabBarItem(img: "ic_profile", title: "", index: 3, selection: $selection)
                        }
                        .tag(3)
                }
                .accentColor(Color.primary())
                .onAppear {
                    UITabBar.appearance().unselectedItemTintColor = .black
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .modify(if: UIDevice.current.userInterfaceIdiom == .pad, then: IPadNavigationViewStyle(), else: IPhoneNavigationViewStyle())
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppState())
    }
}

