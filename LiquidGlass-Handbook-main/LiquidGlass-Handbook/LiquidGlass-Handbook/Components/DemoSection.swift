//
//  DemoSection.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct DemoSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionTitle(title: title)

            content
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
                .frame(width: 4, height: 28)
                .clipShape(RoundedRectangle(cornerRadius: 2))

            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.primary)

            Spacer()
        }
    }
}
