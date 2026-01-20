//
//  AnimatedGradientBackground.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct AnimatedGradientBackground: View, Equatable {
    @State private var animateGradient = false

    var body: some View {
        LinearGradient(
            colors: [
                Color.blue.opacity(0.3),
                Color.purple.opacity(0.3),
                Color.pink.opacity(0.3),
                Color.orange.opacity(0.3)
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }

    static func == (lhs: AnimatedGradientBackground, rhs: AnimatedGradientBackground) -> Bool {
        true
    }
}
