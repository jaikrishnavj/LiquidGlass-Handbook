//
//  ModernChapterCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ModernChapterCard: View, Equatable {
    let chapter: Chapter

    var body: some View {
        HStack(spacing: 16) {
            IconCircle(icon: chapter.icon, color: chapter.color)

            ContentArea(
                number: chapter.id,
                title: chapter.title,
                subtitle: chapter.subtitle
            )

            Spacer(minLength: 8)

            ChevronIcon()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(RowBackground(color: chapter.color))
    }

    static func == (lhs: ModernChapterCard, rhs: ModernChapterCard) -> Bool {
        lhs.chapter == rhs.chapter
    }
}

private struct IconCircle: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.12))
                .frame(width: 52, height: 52)

            Circle()
                .strokeBorder(color.opacity(0.25), lineWidth: 1)
                .frame(width: 52, height: 52)

            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(
                    LinearGradient(
                        colors: [color, color.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

private struct ContentArea: View, Equatable {
    let number: Int
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ChapterBadge(number: number)

            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)

            Text(subtitle)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

private struct ChapterBadge: View, Equatable {
    let number: Int

    var body: some View {
        Text("Chapter \(number)")
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(.tertiary)
            .textCase(.uppercase)
            .tracking(0.5)
    }
}

private struct RowBackground: View, Equatable {
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.ultraThinMaterial)
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [color.opacity(0.05), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(color.opacity(0.15), lineWidth: 0.5)
            }
            .shadow(color: color.opacity(0.15), radius: 8, y: 4)
    }
}

private struct ChevronIcon: View, Equatable {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.quaternary)
    }
}
