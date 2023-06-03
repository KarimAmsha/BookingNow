//
//  TextAnimationModifier.swift
//  BookNow
//
//  Created by Karim Amsha on 1.06.2023.
//

import SwiftUI

struct TextAnimationModifier: AnimatableModifier {
    var scale: CGFloat

    var animatableData: CGFloat {
        get { scale }
        set { scale = newValue }
    }

    func body(content: Content) -> some View {
        content
            .customFont(weight: .semiBold, size: s22)
            .scaleEffect(scale)
    }
}
