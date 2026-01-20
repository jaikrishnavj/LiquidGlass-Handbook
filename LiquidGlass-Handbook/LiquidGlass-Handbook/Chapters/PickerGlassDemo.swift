//
//  PickerGlassDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct PickerGlassDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Try the pickers") {
                PickerGlassLiveDemo()
            }

            ActionButtonsCard(
                title: "Pickers with Glass",
                description: "iOS 26 pickers automatically receive beautiful glass backgrounds. Segmented controls, menus, and wheel pickers all feature translucent materials that adapt to their surroundings. The glass effect makes selections feel lightweight and modern.",
                keyPoints: [
                    "Segmented controls use glass backgrounds",
                    "Picker wheels have translucent styling",
                    "Menu pickers show glass effect",
                    "Color pickers with material support",
                    "Inline and wheel styles available",
                    "Automatic light/dark mode adaptation"
                ],
                code: pickerGlassCode,
                icon: "slider.horizontal.3",
                color: .pink
            )
        }
    }

    private var pickerGlassCode: String {
        """
        struct PickerDemo: View {
            @State private var selection = "Option 1"
            @State private var segmentedSelection = 0

            var body: some View {
                VStack(spacing: 20) {
                    // Segmented Picker
                    Picker("Choose", selection: $segmentedSelection) {
                        Text("First").tag(0)
                        Text("Second").tag(1)
                        Text("Third").tag(2)
                    }
                    .pickerStyle(.segmented)

                    // Menu Picker
                    Picker("Select Option", selection: $selection) {
                        Text("Option 1").tag("Option 1")
                        Text("Option 2").tag("Option 2")
                        Text("Option 3").tag("Option 3")
                    }
                    .pickerStyle(.menu)

                    // Inline Picker
                    Picker("Color", selection: $selection) {
                        Text("Red").tag("Red")
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                    }
                    .pickerStyle(.inline)
                }
            }
        }
        """
    }
}

private struct PickerGlassLiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 30) {
            SegmentedPickerDemo()
            MenuPickerDemo()
            ColorPickerDemo()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

private struct SegmentedPickerDemo: View {
    @State private var selection = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Segmented Picker")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Picker("View Mode", selection: $selection) {
                Label("List", systemImage: "list.bullet").tag(0)
                Label("Grid", systemImage: "square.grid.2x2").tag(1)
                Label("Card", systemImage: "rectangle.stack").tag(2)
            }
            .pickerStyle(.segmented)

            Text("Selected: \(["List View", "Grid View", "Card View"][selection])")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }
}

private struct MenuPickerDemo: View {
    @State private var selectedOption = "Medium"
    let options = ["Small", "Medium", "Large", "Extra Large"]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Menu Picker")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack {
                Label("Size", systemImage: "textformat.size")
                    .font(.subheadline)

                Spacer()

                Picker("Size", selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

private struct ColorPickerDemo: View {
    @State private var selectedColor = Color.blue

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color Picker")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 16) {
                ForEach([Color.red, Color.blue, Color.green, Color.orange, Color.purple], id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                        )
                        .overlay(
                            Circle()
                                .strokeBorder(color.opacity(0.5), lineWidth: 2)
                        )
                        .shadow(color: selectedColor == color ? color.opacity(0.5) : .clear,
                               radius: selectedColor == color ? 8 : 0)
                        .scaleEffect(selectedColor == color ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3), value: selectedColor)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }
}
