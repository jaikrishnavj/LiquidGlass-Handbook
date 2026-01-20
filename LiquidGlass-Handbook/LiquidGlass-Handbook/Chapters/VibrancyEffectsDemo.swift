//
//  VibrancyEffectsDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct VibrancyEffectsDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InfoCard(
                title: "Liquid Glass Effects",
                description: "Apply liquid glass effects to text and shapes that adapt to their background with translucent, dynamic appearances.",
                icon: "sparkles",
                color: .green
            )

            DemoSection(title: "Live Demo") {
                LiquidGlassLiveDemo()
            }

            CodeSection(title: "Code Example", code: liquidGlassCode, language: "swift")

            KeyPointsCard(points: [
                ".glassEffect() applies default liquid glass to any view",
                ".glassEffect(in:) constrains glass to a specific shape",
                "Glass effects adapt to content and motion",
                "Works with .ultraThinMaterial for layered effects"
            ])
        }
    }

    private var liquidGlassCode: String {
        """
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.blue, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 16) {
                // Default glass effect
                Text("Liquid Glass")
                    .font(.title)
                    .padding()
                    .glassEffect()

                // Glass with custom shape
                Text("Rounded Glass")
                    .font(.headline)
                    .padding()
                    .glassEffect(in: .rect(cornerRadius: 16))

                // Glass with material background
                HStack {
                    Image(systemName: "star.fill")
                    Text("Glass + Material")
                }
                .padding()
                .background(.ultraThinMaterial)
                .glassEffect()
            }
            .padding()
        }
        """
    }
}

private struct LiquidGlassLiveDemo: View, Equatable {
    var body: some View {
        ZStack {
            LiquidGlassBackground()

            LiquidGlassCards()
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct LiquidGlassBackground: View, Equatable {
    var body: some View {
        LinearGradient(
            colors: [.blue, .purple, .pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct LiquidGlassCards: View, Equatable {
    var body: some View {
        VStack(spacing: 20) {
            Text("Default Glass")
                .font(.headline)
                .padding()
                .glassEffect()

            Text("Rounded Glass")
                .font(.headline)
                .padding()
                .glassEffect(in: .rect(cornerRadius: 16))
        }
    }
}
