//
//  ActionButtonsCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ActionButtonsCard: View, Equatable {
    let title: String
    let description: String
    let keyPoints: [String]
    let code: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 20) {
            CardHeader(title: title, icon: icon, color: color)

            QuickDescription(description: description)

            ActionButtons(
                title: title,
                description: description,
                keyPoints: keyPoints,
                code: code,
                icon: icon,
                color: color
            )
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
    }

    static func == (lhs: ActionButtonsCard, rhs: ActionButtonsCard) -> Bool {
        lhs.title == rhs.title && lhs.code == rhs.code
    }
}

private struct CardHeader: View, Equatable {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 48, height: 48)
                .background(
                    Circle()
                        .fill(color.opacity(0.15))
                )

            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.primary)

            Spacer()
        }
    }
}

private struct QuickDescription: View, Equatable {
    let description: String

    var body: some View {
        Text(description)
            .font(.system(size: 15, weight: .regular))
            .foregroundStyle(.secondary)
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ActionButtons: View, Equatable {
    let title: String
    let description: String
    let keyPoints: [String]
    let code: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            NavigationLink(value: NavigationDestination.explanation(
                title: title,
                description: description,
                keyPoints: keyPoints,
                icon: icon,
                color: color
            )) {
                LargeActionButton(
                    title: "View Explanation",
                    icon: "doc.text.fill",
                    color: .blue
                )
            }
            .buttonStyle(.plain)

            NavigationLink(value: NavigationDestination.code(
                title: "\(title) - Code",
                code: code,
                language: "swift"
            )) {
                LargeActionButton(
                    title: "View Code",
                    icon: "chevron.left.forwardslash.chevron.right",
                    color: .purple
                )
            }
            .buttonStyle(.plain)
        }
    }
}

private struct LargeActionButton: View, Equatable {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(
                    LinearGradient(
                        colors: [color, color.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.thinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(color.opacity(0.3), lineWidth: 1.5)
        )
    }
}

enum NavigationDestination: Hashable {
    case explanation(title: String, description: String, keyPoints: [String], icon: String, color: Color)
    case code(title: String, code: String, language: String)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .explanation(let title, _, _, _, _):
            hasher.combine("explanation")
            hasher.combine(title)
        case .code(let title, _, _):
            hasher.combine("code")
            hasher.combine(title)
        }
    }

    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.explanation(let lTitle, _, _, _, _), .explanation(let rTitle, _, _, _, _)):
            return lTitle == rTitle
        case (.code(let lTitle, _, _), .code(let rTitle, _, _)):
            return lTitle == rTitle
        default:
            return false
        }
    }
}

extension Color: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}
