//
//  MaterialHierarchyDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct MaterialHierarchyDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                MaterialHierarchyLiveDemo()
            }

            ActionButtonsCard(
                title: "Material Hierarchy",
                description: "iOS 26 provides four levels of material thickness: ultraThin, thin, regular, and thick. Each creates different levels of translucency and blur, allowing you to create depth and visual hierarchy in your interface. Choose the right material based on the content importance and the level of emphasis you want to achieve.",
                keyPoints: [
                    "ultraThin: Minimal blur, maximum transparency",
                    "thin: Light blur for subtle separation",
                    "regular: Standard blur for most UI elements",
                    "thick: Heavy blur for strong emphasis",
                    "Materials adapt to light and dark mode automatically",
                    "Stack materials to create depth and layering effects"
                ],
                code: materialCode,
                icon: "square.stack.3d.up.fill",
                color: .cyan
            )
        }
    }

    private var materialCode: String {
        """
        VStack(spacing: 16) {
            // Ultra thin material
            Text("Ultra Thin Material")
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Thin material
            Text("Thin Material")
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Regular material
            Text("Regular Material")
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Thick material
            Text("Thick Material")
                .padding()
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        """
    }
}

private struct MaterialHierarchyLiveDemo: View, Equatable {
    var body: some View {
        ZStack {
            ColorfulBackground()

            MaterialCardsStack()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct ColorfulBackground: View, Equatable {
    var body: some View {
        LinearGradient(
            colors: [.blue, .purple, .pink, .orange],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct MaterialCardsStack: View, Equatable {
    var body: some View {
        VStack(spacing: 16) {
            MaterialCard(material: .ultraThinMaterial, title: "Ultra Thin")
            MaterialCard(material: .thinMaterial, title: "Thin")
            MaterialCard(material: .regularMaterial, title: "Regular")
            MaterialCard(material: .thickMaterial, title: "Thick")
        }
        .padding()
    }
}
