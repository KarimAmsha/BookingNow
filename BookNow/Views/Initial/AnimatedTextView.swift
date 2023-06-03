//
//  AnimatedTextView.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI

struct AnimatedTextView: View {
    @State private var textScale: CGFloat = 1.0

    var body: some View {
        Text("Book Now")
            .modifier(TextAnimationModifier(scale: textScale))
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                    textScale = 1.2
                }
            }
    }
}
