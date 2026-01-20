//
//  CodeSection.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct CodeSection: View, Equatable {
    let title: String
    let code: String
    let language: String
    @State private var showCode = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ToggleButton(title: title, showCode: $showCode)

            if showCode {
                CodeDisplay(code: code)
            }
        }
    }

    static func == (lhs: CodeSection, rhs: CodeSection) -> Bool {
        lhs.title == rhs.title &&
        lhs.code == rhs.code &&
        lhs.language == rhs.language
    }
}

private struct ToggleButton: View {
    let title: String
    @Binding var showCode: Bool

    var body: some View {
        Button(action: { withAnimation { showCode.toggle() } }) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: showCode ? "chevron.up" : "chevron.down")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct CodeDisplay: View, Equatable {
    let code: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(.primary)
                .padding()
        }
        .background(Color.black.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
