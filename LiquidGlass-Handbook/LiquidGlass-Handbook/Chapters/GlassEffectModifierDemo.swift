//
//  GlassEffectModifierDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct GlassEffectModifierDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InfoCard(
                title: "Liquid Glass Effect Modifier",
                description: "Apply liquid glass effects to any custom view using the .glassEffect() modifier for floating UI elements and cards.",
                icon: "wand.and.stars",
                color: .pink
            )

            DemoSection(title: "Live Demo") {
                GlassEffectLiveDemo()
            }

            CodeSection(title: "Code Example", code: glassEffectCode, language: "swift")

            KeyPointsCard(points: [
                ".glassEffect() applies default liquid glass to any view",
                ".glassEffect(in:) constrains glass to a specific shape",
                "Perfect for floating buttons, cards, and overlays",
                "Glass effects adapt dynamically to content"
            ])
        }
    }

    private var glassEffectCode: String {
        """
        ZStack(alignment: .bottomTrailing) {
            // Main content
            ScrollView {
                // Your content
            }

            // Floating action button with glass
            Button(action: {
                // Action
            }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .padding()
            }
            .glassEffect()
            .padding()
        }

        // Glass card with custom shape
        VStack(spacing: 12) {
            Image(systemName: "star.fill")
            Text("Featured")
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: 16))
        """
    }
}

private struct GlassEffectLiveDemo: View, Equatable {
    var body: some View {
        ZStack {
            GlassEffectBackground()

            GlassEffectCards()
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct GlassEffectBackground: View, Equatable {
    var body: some View {
        LinearGradient(
            colors: [.purple, .pink, .orange],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct GlassEffectCards: View, Equatable {
    var body: some View {
        VStack(spacing: 20) {
            GlassCard(icon: "star.fill", title: "Default Glass")

            GlassCard(icon: "heart.fill", title: "Shaped Glass")
        }
    }
}

private struct GlassCard: View, Equatable {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
            Text(title)
                .font(.headline)
        }
        .padding()
        .glassEffect()
    }
}
