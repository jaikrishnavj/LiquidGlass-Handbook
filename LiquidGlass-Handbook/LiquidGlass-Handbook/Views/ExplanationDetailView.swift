//
//  ExplanationDetailView.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ExplanationDetailView: View {
    let title: String
    let description: String
    let keyPoints: [String]
    let icon: String
    let color: Color

    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                ExplanationHeader(icon: icon, color: color)

                DescriptionSection(description: description)

                KeyPointsSection(keyPoints: keyPoints)
            }
            .padding(24)
        }
        .background(WaterDropletBackground())
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isBookmarked.toggle()
                }) {
                    Label(
                        isBookmarked ? "Bookmarked" : "Bookmark",
                        systemImage: isBookmarked ? "bookmark.fill" : "bookmark"
                    )
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: description) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
}

private struct ExplanationHeader: View, Equatable {
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundStyle(
                    .linearGradient(
                        colors: [color, color.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            Spacer()
        }
        .padding(.vertical)
    }
}

private struct DescriptionSection: View, Equatable {
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle(title: "Overview")

            Text(description)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.primary)
                .lineSpacing(4)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

private struct KeyPointsSection: View, Equatable {
    let keyPoints: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitle(title: "Key Points")

            VStack(alignment: .leading, spacing: 16) {
                ForEach(keyPoints, id: \.self) { point in
                    KeyPointRow(point: point)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

private struct SectionTitle: View, Equatable {
    let title: String

    var body: some View {
        HStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.blue, .cyan],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 4, height: 24)
                .clipShape(RoundedRectangle(cornerRadius: 2))

            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.primary)
        }
    }
}

private struct KeyPointRow: View, Equatable {
    let point: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(
                    LinearGradient(
                        colors: [.green, .mint],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .font(.system(size: 18))

            Text(point)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.primary)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
