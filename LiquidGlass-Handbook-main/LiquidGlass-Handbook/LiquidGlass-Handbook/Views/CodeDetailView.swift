//
//  CodeDetailView.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct CodeDetailView: View {
    let title: String
    let code: String
    let language: String

    @State private var isCopied = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CodeContent(code: code, language: language)
            }
            .padding(24)
        }
        .background(WaterDropletBackground())
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    UIPasteboard.general.string = code
                    isCopied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isCopied = false
                    }
                }) {
                    Label(isCopied ? "Copied!" : "Copy", systemImage: isCopied ? "checkmark" : "doc.on.doc")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: code) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
}

private struct CodeContent: View, Equatable {
    let code: String
    let language: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LanguageBadge(language: language)

            CodeBlock(code: code)
        }
    }

    static func == (lhs: CodeContent, rhs: CodeContent) -> Bool {
        lhs.code == rhs.code && lhs.language == rhs.language
    }
}

private struct LanguageBadge: View, Equatable {
    let language: String

    var body: some View {
        Text(language.uppercased())
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.blue, in: Capsule())
    }
}

private struct CodeBlock: View, Equatable {
    let code: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            Text(code)
                .font(.system(size: 15, design: .monospaced))
                .foregroundStyle(.primary)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.blue.opacity(0.3), lineWidth: 1.5)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
    }
}
