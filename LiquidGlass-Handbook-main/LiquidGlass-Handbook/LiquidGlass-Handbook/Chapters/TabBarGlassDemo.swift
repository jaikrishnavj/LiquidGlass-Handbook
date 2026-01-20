//
//  TabBarGlassDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct TabBarGlassDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InfoCard(
                title: "Tab Bar with Glass",
                description: "iOS 26 tab bars can be left-aligned with glass capsules, creating a modern floating appearance.",
                icon: "square.split.bottomrightquarter",
                color: .orange
            )

            DemoSection(title: "Live Demo") {
                TabBarLiveDemo()
            }

            CodeSection(title: "Code Example", code: tabBarCode, language: "swift")

            KeyPointsCard(points: [
                "Tab bars float above content with glass backgrounds",
                "Can be left-aligned or centered",
                "Minimize on scroll with .tabBarMinimizeBehavior()",
                "Content extends underneath for layered effect"
            ])
        }
    }

    private var tabBarCode: String {
        """
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        // Minimize tab bar when scrolling
        .tabBarMinimizeBehavior(.onScrollDown)
        """
    }
}

struct TabBarLiveDemo: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TabViewContent(tab: 0, items: (1...10).map { "Home Item \($0)" })

            TabViewContent(tab: 1, items: (1...10).map { "Search Result \($0)" })

            TabViewContent(tab: 2, items: (1...10).map { "Setting \($0)" })
        }
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct TabViewContent: View, Equatable {
    let tab: Int
    let items: [String]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
        .tag(tab)
        .tabItem {
            Label(tabLabel, systemImage: tabIcon)
        }
    }

    private var tabLabel: String {
        switch tab {
        case 0: return "Home"
        case 1: return "Search"
        case 2: return "Settings"
        default: return ""
        }
    }

    private var tabIcon: String {
        switch tab {
        case 0: return "house.fill"
        case 1: return "magnifyingglass"
        case 2: return "gearshape.fill"
        default: return ""
        }
    }
}
