//
//  SheetGlassDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct SheetGlassDemo: View {
    @State private var showSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                SheetGlassDemoButton(showSheet: $showSheet)
            }
            .sheet(isPresented: $showSheet) {
                SheetContent()
            }

            ActionButtonsCard(
                title: "Sheet Glass Backgrounds",
                description: "Sheets use translucent glass materials that create depth and visual hierarchy. Use .presentationBackground() with materials like .ultraThinMaterial, .thinMaterial, or custom colors with opacity. The demo shows multiple presentation detents with glass toolbar buttons and floating action buttons.",
                keyPoints: [
                    "Sheets support .presentationBackground() with materials",
                    "Use .ultraThinMaterial or .thinMaterial for glass effect",
                    "Presentation detents (.medium, .large) work with glass",
                    ".glass button style in sheet toolbars",
                    "Floating glass action buttons over content",
                    "Drag indicator automatically adapts to background"
                ],
                code: sheetGlassCode,
                icon: "square.on.square",
                color: .mint
            )
        }
    }

    private var sheetGlassCode: String {
        """
        struct SheetContent: View {
            @Environment(\\.dismiss) var dismiss

            var body: some View {
                NavigationStack {
                    ZStack(alignment: .bottom) {
                        List {
                            Section("Settings") {
                                Toggle("Notifications", isOn: $enabled)
                                // More content...
                            }
                        }
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 70)
                        }

                        // Floating glass action bar
                        HStack {
                            Button(action: {}) {
                                Label("Favorite", systemImage: "heart")
                            }
                            .buttonStyle(.glass)

                            Spacer()

                            Button("Apply") {}
                                .buttonStyle(.glassProminent)
                        }
                        .padding()
                        .background(.thinMaterial)
                    }
                    .navigationTitle("Glass Sheet")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close", systemImage: "xmark.circle") {}
                                .buttonStyle(.glass)
                        }

                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") { dismiss() }
                                .buttonStyle(.glassProminent)
                        }
                    }
                }
                .presentationBackground(.ultraThinMaterial)
                .presentationDetents([.medium, .large])
            }
        }
        """
    }
}

private struct SheetGlassDemoButton: View, Equatable {
    @Binding var showSheet: Bool

    var body: some View {
        VStack(spacing: 16) {
            Button("Show Glass Sheet") {
                showSheet = true
            }
            .buttonStyle(.glassProminent)
            .controlSize(.large)

            Text("Tap to see glass materials in sheet presentation")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    static func == (lhs: SheetGlassDemoButton, rhs: SheetGlassDemoButton) -> Bool {
        true
    }
}

struct SheetContent: View {
    @Environment(\.dismiss) var dismiss
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var soundEnabled = true
    @State private var locationEnabled = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    Section("Settings") {
                        Toggle("Notifications", isOn: $notificationsEnabled)
                        Toggle("Dark Mode", isOn: $darkModeEnabled)
                        Toggle("Sound Effects", isOn: $soundEnabled)
                        Toggle("Location Services", isOn: $locationEnabled)
                    }

                    Section("Glass Effects") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("This sheet uses .ultraThinMaterial")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.primary)

                            Text("Notice the translucent glass background that blurs content behind it. The floating action bar below also uses .thinMaterial.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }

                    Section {
                        ForEach(1...5, id: \.self) { item in
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("Feature \(item)")
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 70)
                }

                FloatingGlassActionBar()
            }
            .navigationTitle("Glass Sheet Demo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Label("Close", systemImage: "xmark.circle.fill")
                    }
                    .buttonStyle(.glass)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
        .presentationBackground(.ultraThinMaterial)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

private struct FloatingGlassActionBar: View, Equatable {
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Label("Favorite", systemImage: "heart")
            }
            .buttonStyle(.glass)

            Button(action: {}) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.glass)

            Spacer()

            Button(action: {}) {
                Label("Apply", systemImage: "checkmark.circle.fill")
            }
            .buttonStyle(.glassProminent)
        }
        .padding()
        .background(.thinMaterial)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.quaternary.opacity(0.5))
                .frame(height: 0.5)
        }
    }
}
