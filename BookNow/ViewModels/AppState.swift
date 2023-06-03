//
//  AppState.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var isAnimating: Bool = false
    @Published var shouldAnimating: Bool = false
    @Published var showingSucessToast: Bool = false
    @Published var showingErrorToast: Bool = false
    @Published var toastMessage: String = ""

    func showingActivityIndicator(_ status: Bool) {
        shouldAnimating = status
    }
    
    func showSuccessToast(_ msg: String) {
        shouldAnimating = false
        showingSucessToast = true
        showingErrorToast = false
        toastMessage = msg
    }
    
    func showErrorToast(_ msg: String) {
        shouldAnimating = false
        showingErrorToast = true
        showingSucessToast = false
        toastMessage = msg
    }
    
    func cleanToasts() {
        showingSucessToast = false
        showingErrorToast = false
        toastMessage = ""
    }
}
