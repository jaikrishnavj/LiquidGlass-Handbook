//
//  SearchGlassDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct SearchGlassDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                SearchLiveDemo()
            }

            ActionButtonsCard(
                title: "Search with Glass",
                description: "Search bars in iOS 26 appear in toolbars with glass backgrounds, placing them within easy reach at the bottom of the screen. The searchable modifier provides a beautiful, integrated search experience that feels native to iOS 26's design language.",
                keyPoints: [
                    "Search appears in toolbar with glass background",
                    "Can be placed in trailing corner or bottom",
                    "Expands when tapped for better focus",
                    "Use .searchable() modifier for easy integration",
                    "Supports custom prompts and suggestions",
                    "Automatically dismisses with cancel button"
                ],
                code: searchCode,
                icon: "magnifyingglass",
                color: .red
            )
        }
    }

    private var searchCode: String {
        """
        NavigationStack {
            List {
                ForEach(items.filter {
                    searchText.isEmpty || $0.contains(searchText)
                }) { item in
                    Text(item)
                }
            }
            .navigationTitle("Search Demo")
            .searchable(text: $searchText, prompt: "Search items")
        }

        // For NavigationSplitView (iPad/Mac)
        NavigationSplitView {
            // Sidebar
        } detail: {
            // Detail view
        }
        .searchable(text: $searchText)
        // Search appears in top trailing corner on iPad
        """
    }
}

struct SearchLiveDemo: View {
    @State private var searchText = ""
    let items = ["iPhone", "iPad", "Mac", "Apple Watch", "AirPods", "Vision Pro"]

    var body: some View {
        List {
            ForEach(filteredItems, id: \.self) { item in
                SearchResultRow(item: item)
            }
        }
        .navigationTitle("Products")
        .searchable(text: $searchText, prompt: "Search products")
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var filteredItems: [String] {
        searchText.isEmpty ? items : items.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
}

private struct SearchResultRow: View, Equatable {
    let item: String

    var body: some View {
        HStack {
            Image(systemName: "apple.logo")
                .foregroundStyle(.gray)
            Text(item)
        }
    }
}
