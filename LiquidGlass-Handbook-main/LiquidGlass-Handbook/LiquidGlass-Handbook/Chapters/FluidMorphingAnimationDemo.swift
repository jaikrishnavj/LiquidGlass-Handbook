//
//  FluidMorphingAnimationDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct FluidMorphingAnimationDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Interactive Liquid Glass") {
                LiquidGlassInteractiveDemo()
            }

            DemoSection(title: "Morphing Transitions") {
                LiquidGlassMorphingDemo()
            }

            DemoSection(title: "Unified Glass Effects") {
                LiquidGlassUnifiedDemo()
            }

            ActionButtonsCard(
                title: "Liquid Glass - iOS 26",
                description: "Liquid Glass combines optical properties of glass with fluidity. It blurs content behind it, reflects surrounding colors and light, and reacts to touch and pointer interactions in real time. Use GlassEffectContainer to blend multiple glass effects together and morph shapes seamlessly during transitions.",
                keyPoints: [
                    "glassEffect() modifier for applying Liquid Glass",
                    "GlassEffectContainer for morphing multiple views",
                    "glassEffectID(_:in:) for coordinated transitions",
                    "glassEffectUnion(id:namespace:) for unified effects",
                    "interactive() modifier for touch/pointer reactions",
                    "Configurable shapes, tints, and spacing"
                ],
                code: liquidGlassCode,
                icon: "waveform.path.ecg",
                color: .purple
            )
        }
    }

    private var liquidGlassCode: String {
        """
        // Basic Liquid Glass Effect
        Text("Hello, World!")
            .font(.title)
            .padding()
            .glassEffect()

        // Custom shape and tint with interactivity
        Text("Hello, World!")
            .font(.title)
            .padding()
            .glassEffect(.regular.tint(.orange).interactive())
            .glassEffect(in: .rect(cornerRadius: 16.0))

        // Morphing with GlassEffectContainer
        @State private var isExpanded = false
        @Namespace private var namespace

        GlassEffectContainer(spacing: 40.0) {
            HStack(spacing: 40.0) {
                Image(systemName: "scribble.variable")
                    .frame(width: 80, height: 80)
                    .font(.system(size: 36))
                    .glassEffect()
                    .glassEffectID("pencil", in: namespace)

                if isExpanded {
                    Image(systemName: "eraser.fill")
                        .frame(width: 80, height: 80)
                        .font(.system(size: 36))
                        .glassEffect()
                        .glassEffectID("eraser", in: namespace)
                }
            }
        }

        // Unified glass effects
        let symbols = ["cloud.bolt.rain.fill", "sun.rain.fill"]

        GlassEffectContainer(spacing: 20.0) {
            HStack(spacing: 20.0) {
                ForEach(symbols.indices, id: \\.self) { index in
                    Image(systemName: symbols[index])
                        .frame(width: 80, height: 80)
                        .font(.system(size: 36))
                        .glassEffect()
                        .glassEffectUnion(id: "weather", namespace: namespace)
                }
            }
        }
        """
    }
}

// MARK: - Interactive Liquid Glass Demo
private struct LiquidGlassInteractiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 24) {
            InteractiveGlassButton(title: "Interactive Glass", icon: "hand.tap.fill", color: .blue)
            InteractiveGlassButton(title: "With Tint", icon: "paintbrush.fill", color: .purple)
            InteractiveGlassButton(title: "Custom Shape", icon: "square.fill", color: .orange)
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.1), .purple.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}

private struct InteractiveGlassButton: View, Equatable {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
            Text(title)
                .font(.system(size: 16, weight: .semibold))
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .glassEffect(.regular.tint(color).interactive())
    }
}

// MARK: - Morphing Transitions Demo
private struct LiquidGlassMorphingDemo: View {
    @State private var isExpanded = false
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 32) {
            GlassEffectContainer(spacing: 40.0) {
                HStack(spacing: 40.0) {
                    GlassSymbolView(
                        symbol: "scribble.variable",
                        color: .blue,
                        id: "pencil",
                        namespace: namespace
                    )

                    if isExpanded {
                        GlassSymbolView(
                            symbol: "eraser.fill",
                            color: .pink,
                            id: "eraser",
                            namespace: namespace
                        )
                        .glassEffectTransition(.matchedGeometry)
                    }
                }
            }

            ToggleButton(isExpanded: $isExpanded)
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.pink.opacity(0.1), .blue.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}

private struct GlassSymbolView: View, Equatable {
    let symbol: String
    let color: Color
    let id: String
    let namespace: Namespace.ID

    var body: some View {
        Image(systemName: symbol)
            .frame(width: 80, height: 80)
            .font(.system(size: 36))
            .foregroundStyle(color)
            .glassEffect(.regular.tint(color))
            .glassEffectID(id, in: namespace)
    }

    static func == (lhs: GlassSymbolView, rhs: GlassSymbolView) -> Bool {
        lhs.symbol == rhs.symbol && lhs.id == rhs.id
    }
}

private struct ToggleButton: View, Equatable {
    @Binding var isExpanded: Bool

    var body: some View {
        Button(action: {
            withAnimation(.smooth(duration: 0.6)) {
                isExpanded.toggle()
            }
        }) {
            Label(
                isExpanded ? "Hide Eraser" : "Show Eraser",
                systemImage: isExpanded ? "eye.slash.fill" : "eye.fill"
            )
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
            .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y: 5)
        }
    }

    static func == (lhs: ToggleButton, rhs: ToggleButton) -> Bool {
        lhs.isExpanded == rhs.isExpanded
    }
}

// MARK: - Unified Glass Effects Demo
private struct LiquidGlassUnifiedDemo: View {
    @Namespace private var namespace

    var body: some View {
        UnifiedGlassContent(namespace: namespace)
            .padding(32)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [.orange.opacity(0.1), .pink.opacity(0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}

private struct UnifiedGlassContent: View, Equatable {
    let namespace: Namespace.ID
    private let weatherSymbols = ["cloud.bolt.rain.fill", "sun.rain.fill"]
    private let celestialSymbols = ["moon.stars.fill", "moon.fill"]

    var body: some View {
        GlassEffectContainer(spacing: 20.0) {
            VStack(spacing: 32) {
                UnifiedSymbolRow(
                    symbols: weatherSymbols,
                    unionID: "weather",
                    namespace: namespace,
                    color: .blue
                )

                UnifiedSymbolRow(
                    symbols: celestialSymbols,
                    unionID: "celestial",
                    namespace: namespace,
                    color: .purple
                )
            }
        }
    }

    static func == (lhs: UnifiedGlassContent, rhs: UnifiedGlassContent) -> Bool {
        true
    }
}

private struct UnifiedSymbolRow: View, Equatable {
    let symbols: [String]
    let unionID: String
    let namespace: Namespace.ID
    let color: Color

    var body: some View {
        HStack(spacing: 20.0) {
            ForEach(symbols.indices, id: \.self) { index in
                Image(systemName: symbols[index])
                    .frame(width: 80, height: 80)
                    .font(.system(size: 36))
                    .foregroundStyle(color)
                    .glassEffect(.regular.tint(color))
                    .glassEffectUnion(id: unionID, namespace: namespace)
            }
        }
    }

    static func == (lhs: UnifiedSymbolRow, rhs: UnifiedSymbolRow) -> Bool {
        lhs.symbols == rhs.symbols && lhs.unionID == rhs.unionID
    }
}
