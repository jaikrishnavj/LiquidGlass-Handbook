//
//  SystemGlassComponentsDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct SystemGlassComponentsDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Tap to trigger") {
                SystemGlassLiveDemo()
            }

            ActionButtonsCard(
                title: "System Components with Glass",
                description: "Many SwiftUI system components automatically include glass effects without any configuration. Alerts, confirmation dialogs, menus, context menus, and sliders can all feature glass backgrounds that adapt to your app's interface.",
                keyPoints: [
                    "Alert dialogs have automatic glass backgrounds",
                    "ConfirmationDialog uses glass styling",
                    "Menu and ContextMenu include glass effects",
                    "Sliders can be styled with glass backgrounds",
                    "System adapts glass to light/dark mode",
                    "Glass effects match iOS system design"
                ],
                code: systemGlassCode,
                icon: "square.grid.3x3.square",
                color: .teal
            )
        }
    }

    private var systemGlassCode: String {
        """
        struct SystemGlassExample: View {
            @State private var showAlert = false
            @State private var showDialog = false
            @State private var volume: Double = 0.5

            var body: some View {
                VStack(spacing: 20) {
                    // Alert with automatic glass
                    Button("Show Alert") {
                        showAlert = true
                    }
                    .alert("Glass Alert", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                        Button("Delete", role: .destructive) { }
                    } message: {
                        Text("Alerts have automatic glass backgrounds")
                    }

                    // ConfirmationDialog with glass
                    Button("Show Dialog") {
                        showDialog = true
                    }
                    .confirmationDialog(
                        "Glass Dialog",
                        isPresented: $showDialog
                    ) {
                        Button("Confirm") { }
                        Button("Cancel", role: .cancel) { }
                    }

                    // Menu with automatic glass
                    Menu("Glass Menu") {
                        Button("Action 1") { }
                        Button("Action 2") { }
                        Divider()
                        Button("Delete", role: .destructive) { }
                    }

                    // Slider with glass background
                    VStack {
                        Label("Volume", systemImage: "speaker.wave.2")
                        Slider(value: $volume, in: 0...1)
                    }
                    .padding()
                    .glassEffect()

                    // Context menu with glass
                    Text("Long press me")
                        .contextMenu {
                            Button("Copy") { }
                            Button("Share") { }
                        }
                }
            }
        }
        """
    }
}

private struct SystemGlassLiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 30) {
            AlertDemo()
            ConfirmationDialogDemo()
            MenuDemo()
            SliderDemo()
            ContextMenuDemo()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

private struct AlertDemo: View {
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 12) {
            Text("Alert")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Button {
                showAlert = true
            } label: {
                Text("Show Alert")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .alert("Automatic Glass", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
                Button("Delete", role: .destructive) { }
            } message: {
                Text("This alert has automatic glass background")
            }
        }
    }
}

private struct ConfirmationDialogDemo: View {
    @State private var showDialog = false

    var body: some View {
        VStack(spacing: 12) {
            Text("Confirmation Dialog")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Button {
                showDialog = true
            } label: {
                Text("Show Dialog")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .confirmationDialog(
                "Automatic Glass Dialog",
                isPresented: $showDialog,
                titleVisibility: .visible
            ) {
                Button("Confirm") { }
                Button("Maybe Later") { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This dialog has built-in glass effects")
            }
        }
    }
}

private struct MenuDemo: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Menu")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Menu {
                Button("Action 1", systemImage: "star") { }
                Button("Action 2", systemImage: "heart") { }
                Divider()
                Button("Delete", systemImage: "trash", role: .destructive) { }
            } label: {
                Text("Open Menu")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
    }
}

private struct SliderDemo: View {
    @State private var volume: Double = 0.5
    @State private var brightness: Double = 0.7

    var body: some View {
        VStack(spacing: 16) {
            Text("Sliders with Glass")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "speaker.fill")
                        .foregroundStyle(.blue)
                    Slider(value: $volume, in: 0...1)
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundStyle(.blue)
                }

                HStack {
                    Image(systemName: "sun.min.fill")
                        .foregroundStyle(.orange)
                    Slider(value: $brightness, in: 0...1)
                    Image(systemName: "sun.max.fill")
                        .foregroundStyle(.orange)
                }
            }
            .padding()
            .glassEffect()
        }
    }
}

private struct ContextMenuDemo: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Context Menu")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Text("Long Press Here")
                .font(.body.weight(.medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contextMenu {
                    Button("Copy", systemImage: "doc.on.doc") { }
                    Button("Share", systemImage: "square.and.arrow.up") { }
                    Divider()
                    Button("Delete", systemImage: "trash", role: .destructive) { }
                }
        }
    }
}
