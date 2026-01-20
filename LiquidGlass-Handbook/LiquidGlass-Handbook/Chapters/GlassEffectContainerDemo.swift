//
//  GlassEffectContainerDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct GlassEffectContainerDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                GlassContainerLiveDemo()
            }

            DemoSection(title: "Morphing Animation") {
                GlassMorphingDemo()
            }

            ActionButtonsCard(
                title: "Glass Effect Container",
                description: "GlassEffectContainer groups related UI elements with a unified liquid glass effect. It enables smooth morphing animations between glass elements using glassEffectID. Elements can blend together and morph during transitions, creating fluid visual effects.",
                keyPoints: [
                    "Groups related elements with unified glass background",
                    "Spacing parameter controls distance between items",
                    "Use glassEffectID for morphing animations",
                    "@Namespace enables smooth shape transitions",
                    "Morphing blends elements during state changes",
                    "Works seamlessly with HStack, VStack, and custom layouts"
                ],
                code: glassContainerCode,
                icon: "square.stack.3d.up.fill",
                color: .cyan
            )
        }
    }

    private var glassContainerCode: String {
        """
        // Morphing animation with glassEffectID
        @State private var isExpanded = false
        @Namespace private var namespace

        GlassEffectContainer(spacing: 40.0) {
            HStack(spacing: 40.0) {
                Image(systemName: "pencil")
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

        Button("Toggle") {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .buttonStyle(.glass)

        // Individual element glass effects
        GlassEffectContainer(spacing: 30.0) {
            HStack {
                Image(systemName: "sun.max.fill")
                    .padding()
                    .glassEffect()

                Image(systemName: "moon.stars.fill")
                    .padding()
                    .glassEffect()
            }
        }

        // Unified container glass effect
        GlassEffectContainer(spacing: 20.0) {
            VStack {
                HStack {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
                .padding()
            }
        }
        .glassEffect()
        """
    }
}

private struct GlassContainerLiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 24) {
            IndividualEffectsExample()

            UnifiedEffectExample()

            MixedEffectExample()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .glassEffect()
    }
}

private struct IndividualEffectsExample: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionLabel(title: "Individual Glass Effects")

            GlassEffectContainer(spacing: 12) {
                HStack(spacing: 12) {
                    WeatherIconGlass(icon: "sun.max.fill", color: .orange)
                    WeatherIconGlass(icon: "moon.stars.fill", color: .indigo)
                    WeatherIconGlass(icon: "cloud.rain.fill", color: .blue)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct WeatherIconGlass: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 28, weight: .medium))
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .glassEffect(in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        LinearGradient(
                            colors: [color.opacity(0.5), color.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

private struct UnifiedEffectExample: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionLabel(title: "Unified Container Effect")

            GlassEffectContainer(spacing: 0) {
                VStack(spacing: 0) {
                    ActionRow(icon: "heart.fill", title: "Favorite", color: .red)
                    Divider()
                    ActionRow(icon: "star.fill", title: "Featured", color: .yellow)
                    Divider()
                    ActionRow(icon: "bookmark.fill", title: "Saved", color: .green)
                }
            }
            .glassEffect()
        }
    }
}

private struct MixedEffectExample: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionLabel(title: "Control Buttons")

            GlassEffectContainer(spacing: 12) {
                HStack(spacing: 12) {
                    ControlButtonGlass(icon: "play.fill", color: .green)
                    ControlButtonGlass(icon: "pause.fill", color: .orange)
                    ControlButtonGlass(icon: "stop.fill", color: .red)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct ControlButtonGlass: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [color.opacity(0.6), color.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .frame(maxHeight: 60)
        .glassEffect(in: Circle())
        .overlay(
            Circle()
                .strokeBorder(Color.white.opacity(0.6), lineWidth: 1.5)
        )
        .shadow(color: color.opacity(0.4), radius: 6, x: 0, y: 3)
    }
}

private struct SectionLabel: View, Equatable {
    let title: String

    var body: some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
    }
}

private struct WeatherIcon: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        Image(systemName: icon)
            .font(.largeTitle)
            .foregroundStyle(color)
            .padding()
    }
}

private struct ActionRow: View, Equatable {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(title)
                .font(.body)
            Spacer()
        }
        .padding()
    }
}

private struct ControlButton: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        Image(systemName: icon)
            .font(.title2)
            .foregroundStyle(color)
            .padding()
    }
}

private struct GlassMorphingDemo: View {
    @State private var isExpanded = false
    @Namespace private var namespace

    var body: some View {
        VStack(spacing: 24) {
            // Morphing container
            GlassEffectContainer(spacing: 40.0) {
                HStack(spacing: 40.0) {
                    Image(systemName: "pencil")
                        .frame(width: 80, height: 80)
                        .font(.system(size: 36))
                        .foregroundStyle(.blue)
                        .glassEffect()
                        .glassEffectID("pencil", in: namespace)

                    if isExpanded {
                        Image(systemName: "eraser.fill")
                            .frame(width: 80, height: 80)
                            .font(.system(size: 36))
                            .foregroundStyle(.pink)
                            .glassEffect()
                            .glassEffectID("eraser", in: namespace)
                    }
                }
            }

            // Toggle button
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            } label: {
                Text(isExpanded ? "Hide Eraser" : "Show Eraser")
                    .font(.body.weight(.medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.glass)

            // Info text
            Text("Tap to see glass elements morph")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.purple.opacity(0.3), .blue.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}
