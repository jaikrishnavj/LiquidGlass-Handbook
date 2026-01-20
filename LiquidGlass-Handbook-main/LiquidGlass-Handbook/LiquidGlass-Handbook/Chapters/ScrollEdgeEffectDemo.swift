//
//  ScrollEdgeEffectDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ScrollEdgeEffectDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Scroll to see the blur effect") {
                ScrollEdgeLiveDemo()
            }

            ActionButtonsCard(
                title: "Scroll Edge Effects with Glass",
                description: "Content scrolling under glass materials (.ultraThinMaterial, .thinMaterial) automatically receives a blur effect. This demo shows a floating glass header at the top and a glass footer at the bottom with action buttons. Watch how content blurs as it passes behind these glass layers.",
                keyPoints: [
                    "Floating glass headers with .ultraThinMaterial",
                    "Glass footers with .thinMaterial and action buttons",
                    "Content automatically blurs under glass layers",
                    ".glass button style in floating toolbars",
                    "Smooth blur transitions as content scrolls",
                    "Beautiful depth and hierarchy with layered glass"
                ],
                code: scrollEdgeCode,
                icon: "arrow.up.and.down.text.horizontal",
                color: .teal
            )
        }
    }

    private var scrollEdgeCode: String {
        """
        // Floating glass header and footer
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 60) // Space for header

                    ForEach(1...30, id: \\.self) { item in
                        Text("Item \\(item)")
                            .padding()
                    }

                    Spacer().frame(height: 80) // Space for footer
                }
            }
            .background(
                LinearGradient(
                    colors: [.blue.opacity(0.1), .purple.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            VStack(spacing: 0) {
                // Floating glass header
                HStack {
                    Text("Scroll Edge Effect")
                        .font(.headline)
                    Spacer()
                }
                .padding()
                .background(.ultraThinMaterial)

                Spacer()

                // Floating glass footer with buttons
                HStack {
                    Button("Action", systemImage: "star.fill") {}
                        .buttonStyle(.glass)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "arrow.up")
                    }
                    .buttonStyle(.glassProminent)
                }
                .padding()
                .background(.thinMaterial)
            }
        }
        """
    }
}

struct ScrollEdgeLiveDemo: View, Equatable {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 60)

                    ForEach(1...30, id: \.self) { item in
                        ScrollListItem(item: item)
                        Divider()
                    }

                    Spacer()
                        .frame(height: 80)
                }
            }
            .background(
                LinearGradient(
                    colors: [.blue.opacity(0.1), .purple.opacity(0.05), .pink.opacity(0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            VStack(spacing: 0) {
                FloatingGlassHeader()

                Spacer()

                FloatingGlassFooter()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 450)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}

private struct FloatingGlassHeader: View, Equatable {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Scroll Edge Effect")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)

                Text("Glass header with blur")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.system(size: 20))
                .foregroundStyle(.blue)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.quaternary.opacity(0.5))
                .frame(height: 0.5)
        }
    }
}

private struct FloatingGlassFooter: View, Equatable {
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Label("Action", systemImage: "star.fill")
                    .font(.system(size: 14, weight: .medium))
            }
            .buttonStyle(.glass)
            .controlSize(.small)

            Button(action: {}) {
                Label("Options", systemImage: "ellipsis.circle")
                    .font(.system(size: 14, weight: .medium))
            }
            .buttonStyle(.glass)
            .controlSize(.small)

            Spacer()

            Button(action: {}) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 14, weight: .semibold))
            }
            .buttonStyle(.glassProminent)
            .controlSize(.small)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.thinMaterial)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.quaternary.opacity(0.5))
                .frame(height: 0.5)
        }
    }
}

private struct ScrollListItem: View, Equatable {
    let item: Int

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.3), .cyan.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)

                Image(systemName: "\(item).circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.blue)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("List item \(item)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.primary)

                Text("Scroll to see the blur effect")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.01))
    }
}
