//
//  ChapterDetailView.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CompactChapterHeader(chapter: chapter)

                ChapterContent(chapterId: chapter.id)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .background(WaterDropletBackground())
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct CompactChapterHeader: View, Equatable {
    let chapter: Chapter

    var body: some View {
        HStack(spacing: 16) {
            CompactIcon(icon: chapter.icon, color: chapter.color)

            VStack(alignment: .leading, spacing: 4) {
                Text(chapter.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primary)

                Text(chapter.subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    LinearGradient(
                        colors: [chapter.color.opacity(0.4), chapter.color.opacity(0.1)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: chapter.color.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    static func == (lhs: CompactChapterHeader, rhs: CompactChapterHeader) -> Bool {
        lhs.chapter == rhs.chapter
    }
}

private struct CompactIcon: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [color.opacity(0.3), color.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)

            Image(systemName: icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(color)
        }
    }
}

private struct ChapterContent: View, Equatable {
    let chapterId: Int

    var body: some View {
        Group {
            switch chapterId {
            case 1: ToolbarGlassDemo()
            case 2: GlassButtonStylesDemo()
            case 3: SheetGlassDemo()
            case 4: ScrollEdgeEffectDemo()
            case 5: TabBarGlassDemo()
            case 6: GlassEffectModifierDemo()
            case 7: VibrancyEffectsDemo()
            case 8: SearchGlassDemo()
            case 9: GlassEffectContainerDemo()
            case 10: PickerGlassDemo()
            case 11: SystemGlassComponentsDemo()
            case 12: FluidMorphingAnimationDemo()
            default: Text("Coming soon")
            }
        }
    }

    static func == (lhs: ChapterContent, rhs: ChapterContent) -> Bool {
        lhs.chapterId == rhs.chapterId
    }
}
