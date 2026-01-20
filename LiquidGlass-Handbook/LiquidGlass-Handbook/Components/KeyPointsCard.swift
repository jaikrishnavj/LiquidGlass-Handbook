//
//  KeyPointsCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct KeyPointsCard: View, Equatable {
    let points: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Key Points", systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundStyle(.orange)

            PointsList(points: points)
        }
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct PointsList: View, Equatable {
    let points: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(points, id: \.self) { point in
                PointRow(point: point)
            }
        }
    }
}

private struct PointRow: View, Equatable {
    let point: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.caption)
                .foregroundStyle(.green)
                .padding(.top, 2)

            Text(point)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
