//
//  TableOfContentsView.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct TableOfContentsView: View {
    let chapters: [Chapter] = [
        Chapter(id: 1, title: "Toolbar with Liquid Glass", subtitle: "Toolbar buttons with .glass style", icon: "menubar.rectangle", color: .blue),
        Chapter(id: 2, title: "Glass Button Styles", subtitle: ".glass and .glassProminent styles", icon: "button.programmable", color: .purple),
        Chapter(id: 3, title: "Sheet Presentations", subtitle: "Sheets with material backgrounds", icon: "square.on.square", color: .mint),
        Chapter(id: 4, title: "Scroll Edge Effects", subtitle: "Content blur under glass layers", icon: "arrow.up.and.down.text.horizontal", color: .teal),
        Chapter(id: 5, title: "Tab Bar Glass", subtitle: "Tab bars with glass backgrounds", icon: "square.split.bottomrightquarter", color: .orange),
        Chapter(id: 6, title: "Glass Effect Modifier", subtitle: ".glassEffect() for custom views", icon: "wand.and.stars", color: .pink),
        Chapter(id: 7, title: "Liquid Glass Effects", subtitle: "Dynamic translucent glass effects", icon: "sparkles", color: .green),
        Chapter(id: 8, title: "Search with Materials", subtitle: "Searchable modifier with materials", icon: "magnifyingglass", color: .red),
        Chapter(id: 9, title: "Glass Effect Container", subtitle: "Group elements with unified glass", icon: "square.stack.3d.forward.dottedline.fill", color: .blue),
        Chapter(id: 10, title: "Pickers with Glass", subtitle: "Selection controls with glass styling", icon: "slider.horizontal.3", color: .pink),
        Chapter(id: 11, title: "System Glass Components", subtitle: "Alert, Menu, ConfirmationDialog", icon: "square.grid.3x3.square", color: .teal),
        Chapter(id: 12, title: "Fluid Morphing Animation", subtitle: "PhaseAnimator with liquid glass", icon: "waveform.path.ecg", color: .purple)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeroHeader()
                ChaptersList(chapters: chapters)
            }
            .padding(.top, 1)
        }
        .background {
            WaterDropletBackground()
                .ignoresSafeArea()
        }
        .navigationDestination(for: Chapter.self) { chapter in
            ChapterDetailView(chapter: chapter)
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            switch destination {
            case .explanation(let title, let description, let keyPoints, let icon, let color):
                ExplanationDetailView(
                    title: title,
                    description: description,
                    keyPoints: keyPoints,
                    icon: icon,
                    color: color
                )
            case .code(let title, let code, let language):
                CodeDetailView(title: title, code: code, language: language)
            }
        }
    }
}

private struct HeroHeader: View, Equatable {
    var body: some View {
        VStack(spacing: 16) {
            HeroIcon()

            HeroTitle()

            HeroSubtitle()

            HeroDescription()
        }
        .padding(.top, 20)
        .padding(.bottom, 50)
        .padding(.horizontal, 24)
    }
}

private struct HeroIcon: View, Equatable {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.blue.opacity(0.3),
                            Color.cyan.opacity(0.2),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 80
                    )
                )
                .frame(width: 120, height: 120)

            Image(systemName: "sparkles.rectangle.stack.fill")
                .font(.system(size: 56, weight: .medium))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .cyan, .purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .blue.opacity(0.4), radius: 20)
        }
    }
}

private struct HeroTitle: View, Equatable {
    var body: some View {
        Text("iOS 26")
            .font(.system(size: 56, weight: .bold, design: .rounded))
            .foregroundStyle(.primary)
    }
}

private struct HeroSubtitle: View, Equatable {
    var body: some View {
        Text("Liquid Glass Showcase")
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(.secondary)
    }
}

private struct HeroDescription: View, Equatable {
    var body: some View {
        Text("Interactive guide with code examples")
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.tertiary)
            .multilineTextAlignment(.center)
    }
}

private struct ChaptersList: View, Equatable {
    let chapters: [Chapter]

    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(chapters) { chapter in
                NavigationLink(value: chapter) {
                    ModernChapterCard(chapter: chapter)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
    }

    static func == (lhs: ChaptersList, rhs: ChaptersList) -> Bool {
        lhs.chapters == rhs.chapters
    }
}
