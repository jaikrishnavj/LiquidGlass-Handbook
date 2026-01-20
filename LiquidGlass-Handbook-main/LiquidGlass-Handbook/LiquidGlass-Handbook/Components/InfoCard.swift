//
//  InfoCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct InfoCard: View, Equatable {
    let title: String
    let description: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            IconView(icon: icon, color: color)

            TextContent(title: title, description: description)
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    static func == (lhs: InfoCard, rhs: InfoCard) -> Bool {
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.icon == rhs.icon
    }
}

private struct IconView: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        Image(systemName: icon)
            .font(.title2)
            .foregroundStyle(color)
            .frame(width: 40)
    }

    static func == (lhs: IconView, rhs: IconView) -> Bool {
        lhs.icon == rhs.icon
    }
}

private struct TextContent: View, Equatable {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
