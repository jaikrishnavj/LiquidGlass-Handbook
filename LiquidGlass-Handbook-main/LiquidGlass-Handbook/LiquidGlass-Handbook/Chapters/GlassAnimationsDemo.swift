//
//  GlassAnimationsDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct GlassAnimationsDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo - Automatic Animations") {
                GlassAnimationLiveDemo()
            }

            ActionButtonsCard(
                title: "Glass Animations",
                description: "Automatic glass animations with SwiftUI's animation system. Glass elements expand, rotate, and merge together with smooth transitions. Watch as separate glass circles automatically move and overlap, creating beautiful blending effects when they merge.",
                keyPoints: [
                    "Use .task for automatic continuous animations",
                    "Glass circles merge and separate automatically",
                    "Offset animations show glass overlapping",
                    "Spring animations create natural glass motion",
                    "No tap gestures needed - fully automatic",
                    "Pure glass blends beautifully when merged"
                ],
                code: glassAnimationCode,
                icon: "waveform.path.ecg",
                color: .purple
            )
        }
    }

    private var glassAnimationCode: String {
        """
        // Auto-expanding glass
        struct ExpandingGlass: View {
            @State private var isExpanded = false

            var body: some View {
                Color.clear
                    .frame(width: isExpanded ? 120 : 60,
                           height: isExpanded ? 120 : 60)
                    .glassEffect(in: .circle)
                    .animation(.spring(response: 0.6,
                                     dampingFraction: 0.7),
                              value: isExpanded)
                    .task {
                        while !Task.isCancelled {
                            try? await Task.sleep(for: .seconds(1.5))
                            isExpanded.toggle()
                        }
                    }
            }
        }

        // Merging glass circles
        struct MergingGlass: View {
            @State private var isMerged = false

            var body: some View {
                ZStack {
                    // Left glass - moves right to merge
                    Color.clear
                        .frame(width: 60, height: 60)
                        .glassEffect(in: .circle)
                        .offset(x: isMerged ? 0 : -40)

                    // Right glass - moves left to merge
                    Color.clear
                        .frame(width: 60, height: 60)
                        .glassEffect(in: .circle)
                        .offset(x: isMerged ? 0 : 40)
                }
                .task {
                    while !Task.isCancelled {
                        try? await Task.sleep(for: .seconds(1.5))
                        withAnimation(.spring()) {
                            isMerged.toggle()
                        }
                    }
                }
            }
        }
        """
    }
}

private struct GlassAnimationLiveDemo: View, Equatable {
    var body: some View {
        VStack(spacing: 30) {
            ExpandingGlassDemo()
            RotatingGlassDemo()
            MergingGlassDemo()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

private struct ExpandingGlassDemo: View {
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 12) {
            Text("Auto Expanding")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Color.clear
                .frame(width: isExpanded ? 100 : 60,
                       height: isExpanded ? 100 : 60)
                .glassEffect(in: .circle)
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: isExpanded)
                .task {
                    while !Task.isCancelled {
                        try? await Task.sleep(for: .seconds(1.5))
                        isExpanded.toggle()
                    }
                }
        }
    }
}

private struct RotatingGlassDemo: View {
    @State private var rotation: Double = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("Auto Rotating")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            Color.clear
                .frame(width: 80, height: 80)
                .glassEffect(in: .rect(cornerRadius: 16))
                .rotationEffect(.degrees(rotation))
                .animation(.easeInOut(duration: 0.8), value: rotation)
                .task {
                    while !Task.isCancelled {
                        try? await Task.sleep(for: .seconds(1.2))
                        rotation += 90
                    }
                }
        }
    }
}

private struct MergingGlassDemo: View {
    @State private var isMerged = false

    var body: some View {
        VStack(spacing: 12) {
            Text("Auto Merging Glass")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            ZStack {
                // Left glass circle - moves right when merged
                Color.clear
                    .frame(width: 60, height: 60)
                    .glassEffect(in: .circle)
                    .offset(x: isMerged ? 0 : -40, y: 0)
                    .zIndex(0)

                // Right glass circle - moves left when merged
                Color.clear
                    .frame(width: 60, height: 60)
                    .glassEffect(in: .circle)
                    .offset(x: isMerged ? 0 : 40, y: 0)
                    .zIndex(1)
            }
            .frame(height: 80)
            .task {
                while !Task.isCancelled {
                    try? await Task.sleep(for: .seconds(1.5))
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        isMerged.toggle()
                    }
                }
            }
        }
    }
}
