//
//  BookNowApp.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI

@main
struct BookNowApp: App {
    var body: some Scene {
        WindowGroup {
            let appState = AppState()
            ContentView()
                .environment(\.colorScheme, .light)
                .environmentObject(appState)
        }
    }
}
