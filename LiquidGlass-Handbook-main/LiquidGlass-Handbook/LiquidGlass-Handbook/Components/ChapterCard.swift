//
//  ChapterCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ChapterCard: View, Equatable {
    let chapter: Chapter

    var body: some View {
        HStack(spacing: 16) {
            ChapterIcon(chapter: chapter)

            ChapterText(chapter: chapter)

            Spacer()

            ChevronIcon()
        }
        .padding(18)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.white.opacity(0.2), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
    }

    static func == (lhs: ChapterCard, rhs: ChapterCard) -> Bool {
        lhs.chapter == rhs.chapter
    }
}

private struct ChapterIcon: View, Equatable {
    let chapter: Chapter

    var body: some View {
        ZStack {
            Circle()
                .fill(chapter.color.opacity(0.15))
                .frame(width: 56, height: 56)

            Image(systemName: chapter.icon)
                .font(.system(size: 24))
                .foregroundStyle(chapter.color)
        }
    }

    static func == (lhs: ChapterIcon, rhs: ChapterIcon) -> Bool {
        lhs.chapter == rhs.chapter
    }
}

private struct ChapterText: View, Equatable {
    let chapter: Chapter

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Chapter \(chapter.id)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)

                Spacer()
            }

            Text(chapter.title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(chapter.subtitle)
                .font(.caption)
                .foregroundStyle(.tertiary)
                .lineLimit(2)
        }
    }

    static func == (lhs: ChapterText, rhs: ChapterText) -> Bool {
        lhs.chapter == rhs.chapter
    }
}

private struct ChevronIcon: View, Equatable {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.body.weight(.semibold))
            .foregroundStyle(.quaternary)
    }
}
