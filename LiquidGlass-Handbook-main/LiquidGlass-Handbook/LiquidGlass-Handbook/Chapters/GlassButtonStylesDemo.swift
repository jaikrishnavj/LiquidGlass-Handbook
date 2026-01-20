//
//  GlassButtonStylesDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct GlassButtonStylesDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                GlassButtonsLiveDemo()
            }

            ActionButtonsCard(
                title: "Glass Button Styles",
                description: "SwiftUI's .glass and .glassProminent button styles provide translucent, dynamic appearances that adapt to their surroundings. These built-in button styles create a modern, frosted glass aesthetic with support for multiple sizes, icon variations, disabled states, and interactive behaviors.",
                keyPoints: [
                    ".glass provides subtle translucent liquid glass appearance",
                    ".glassProminent adds emphasis with stronger visual presence",
                    "Supports control sizes: .small, .regular, .large",
                    "Works beautifully with SF Symbols and custom labels",
                    "Disabled states with automatic visual feedback",
                    "Dynamic button style switching based on state"
                ],
                code: glassButtonCode,
                icon: "button.programmable",
                color: .purple
            )
        }
    }

    private var glassButtonCode: String {
        """
        VStack(spacing: 16) {
            // Regular glass button
            Button("Glass Button") {
                // Action
            }
            .buttonStyle(.glass)

            // Prominent glass button
            Button("Prominent") {
                // Action
            }
            .buttonStyle(.glassProminent)

            // Different control sizes
            HStack {
                Button("Small") { }
                    .buttonStyle(.glass)
                    .controlSize(.small)

                Button("Regular") { }
                    .buttonStyle(.glass)
                    .controlSize(.regular)

                Button("Large") { }
                    .buttonStyle(.glass)
                    .controlSize(.large)
            }

            // Icon variations
            HStack {
                Button("Heart", systemImage: "heart.fill") { }
                    .buttonStyle(.glassProminent)

                Button("Star", systemImage: "star.fill") { }
                    .buttonStyle(.glassProminent)
            }

            // Interactive counter
            HStack {
                Button(action: { counter -= 1 }) {
                    Label("Minus", systemImage: "minus")
                }
                .buttonStyle(.glass)

                Text("\\(counter)")

                Button(action: { counter += 1 }) {
                    Label("Plus", systemImage: "plus")
                }
                .buttonStyle(.glass)
            }

            // Disabled state
            Button("Disabled Button") { }
                .buttonStyle(.glassProminent)
                .disabled(true)
        }
        """
    }
}

private struct GlassButtonsLiveDemo: View, Equatable {
    @State private var counter = 0
    @State private var isEnabled = true
    @State private var isFavorited = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            RegularGlassButtons()

            ProminentGlassButtons()

            ControlSizesSection()

            ColorVariationsSection()

            InteractiveSection(
                counter: $counter,
                isFavorited: $isFavorited
            )

            DisabledStateSection(isEnabled: isEnabled)

            HStack {
                Text("Enable Buttons")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Toggle("", isOn: $isEnabled)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    static func == (lhs: GlassButtonsLiveDemo, rhs: GlassButtonsLiveDemo) -> Bool {
        true
    }
}

private struct RegularGlassButtons: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Regular Glass")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("Glass Button") {}
                    .buttonStyle(.glass)

                Button("With Icon", systemImage: "star.fill") {}
                    .buttonStyle(.glass)
            }
        }
    }
}

private struct ProminentGlassButtons: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Prominent Glass")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("Prominent") {}
                    .buttonStyle(.glassProminent)

                Button("Save", systemImage: "checkmark") {}
                    .buttonStyle(.glassProminent)
            }
        }
    }
}

private struct ControlSizesSection: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Control Sizes")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("Small") {}
                    .buttonStyle(.glass)
                    .controlSize(.small)

                Button("Regular") {}
                    .buttonStyle(.glass)
                    .controlSize(.regular)

                Button("Large") {}
                    .buttonStyle(.glass)
                    .controlSize(.large)
            }
        }
    }
}

private struct ColorVariationsSection: View, Equatable {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Icon Variations")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                Button("Square", systemImage: "square.fill") {}
                    .buttonStyle(.glassProminent)

                Button("Circle", systemImage: "circle.fill") {}
                    .buttonStyle(.glassProminent)

                Button("Star", systemImage: "star.fill") {}
                    .buttonStyle(.glassProminent)
            }
            .controlSize(.small)

            HStack(spacing: 8) {
                Button("Heart", systemImage: "heart.fill") {}
                    .buttonStyle(.glassProminent)

                Button("Sparkle", systemImage: "sparkles") {}
                    .buttonStyle(.glassProminent)

                Button("Bolt", systemImage: "bolt.fill") {}
                    .buttonStyle(.glassProminent)
            }
            .controlSize(.small)
        }
    }
}

private struct InteractiveSection: View, Equatable {
    @Binding var counter: Int
    @Binding var isFavorited: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Interactive Examples")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button(action: { counter -= 1 }) {
                    Label("Decrement", systemImage: "minus")
                }
                .buttonStyle(.glass)

                Text("\(counter)")
                    .font(.title2.bold())
                    .frame(minWidth: 40)

                Button(action: { counter += 1 }) {
                    Label("Increment", systemImage: "plus")
                }
                .buttonStyle(.glass)
            }

            Button(action: { isFavorited.toggle() }) {
                Label(
                    isFavorited ? "Favorited" : "Favorite",
                    systemImage: isFavorited ? "heart.fill" : "heart"
                )
            }
            .buttonStyle(isFavorited ? .glass(.regular) : .glass)
        }
    }

    static func == (lhs: InteractiveSection, rhs: InteractiveSection) -> Bool {
        lhs.counter == rhs.counter && lhs.isFavorited == rhs.isFavorited
    }
}

private struct DisabledStateSection: View, Equatable {
    let isEnabled: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Disabled State")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("Glass Disabled") {}
                    .buttonStyle(.glass)
                    .disabled(!isEnabled)

                Button("Prominent Disabled", systemImage: "lock") {}
                    .buttonStyle(.glassProminent)
                    .disabled(!isEnabled)
            }
        }
    }
}
