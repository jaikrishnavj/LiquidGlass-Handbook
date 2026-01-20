//
//  GlassOverlapDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct GlassOverlapDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Drag to see overlap") {
                GlassOverlapLiveDemo()
            }

            ActionButtonsCard(
                title: "Glass Overlap & Layering",
                description: "When glass effects overlap, they create beautiful depth and transparency interactions. The overlapping areas blend naturally, creating rich visual depth. Pure glass effects demonstrate how the material adapts to content behind it.",
                keyPoints: [
                    "Overlapping glass creates natural depth effects",
                    "Use .zIndex() to control layering order",
                    "Pure glass effect shows true translucency",
                    "Glass adapts to background content dynamically",
                    "Multiple layers create dimensional depth",
                    "Drag interactions showcase real-time glass blending"
                ],
                code: glassOverlapCode,
                icon: "square.stack.3d.down.right",
                color: .indigo
            )
        }
    }

    private var glassOverlapCode: String {
        """
        struct OverlappingGlass: View {
            @State private var offset = CGSize.zero

            var body: some View {
                ZStack {
                    // Back glass layer
                    Color.clear
                        .frame(width: 120, height: 120)
                        .glassEffect(in: .circle)

                    // Front draggable glass layer
                    Color.clear
                        .frame(width: 100, height: 100)
                        .glassEffect(in: .circle)
                        .offset(offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    offset = value.translation
                                }
                        )
                        .zIndex(1)
                }
            }
        }
        """
    }
}

private struct GlassOverlapLiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 30) {
            DraggableOverlapDemo()
            StackedGlassDemo()
            IntersectingGlassDemo()
        }
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 500)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

private struct DraggableOverlapDemo: View {
    @State private var offset = CGSize.zero

    var body: some View {
        VStack(spacing: 16) {
            Text("Drag to overlap")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            ZStack {
                // Back layer
                Color.clear
                    .frame(width: 100, height: 100)
                    .glassEffect(in: .circle)

                // Draggable front layer
                Color.clear
                    .frame(width: 90, height: 90)
                    .glassEffect(in: .circle)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    offset = .zero
                                }
                            }
                    )
                    .zIndex(1)
            }
            .frame(height: 150)
        }
    }
}

private struct StackedGlassDemo: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Stacked Glass Layers")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            ZStack {
                // Layer 1 (back)
                Color.clear
                    .frame(width: 140, height: 100)
                    .glassEffect(in: .rect(cornerRadius: 16))
                    .offset(x: -30, y: -20)
                    .zIndex(0)

                // Layer 2 (middle)
                Color.clear
                    .frame(width: 140, height: 100)
                    .glassEffect(in: .rect(cornerRadius: 16))
                    .offset(x: 0, y: 0)
                    .zIndex(1)

                // Layer 3 (front)
                Color.clear
                    .frame(width: 140, height: 100)
                    .glassEffect(in: .rect(cornerRadius: 16))
                    .offset(x: 30, y: 20)
                    .zIndex(2)
            }
            .frame(height: 180)
        }
    }
}

private struct IntersectingGlassDemo: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Intersecting Glass")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: -40) {
                Color.clear
                    .frame(width: 80, height: 80)
                    .glassEffect(in: .circle)

                Color.clear
                    .frame(width: 80, height: 80)
                    .glassEffect(in: .circle)

                Color.clear
                    .frame(width: 80, height: 80)
                    .glassEffect(in: .circle)
            }
            .padding()
        }
    }
}
