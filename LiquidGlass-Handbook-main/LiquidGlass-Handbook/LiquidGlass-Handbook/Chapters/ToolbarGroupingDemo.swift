//
//  ToolbarGroupingDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ToolbarGroupingDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InfoCard(
                title: "Toolbar Grouping",
                description: "Group related toolbar items together with ToolbarItemGroup and add spacing with ToolbarSpacer for better organization.",
                icon: "square.grid.3x1.below.line.grid.1x2",
                color: .indigo
            )

            DemoSection(title: "Live Demo") {
                ToolbarGroupingLiveDemo()
            }

            CodeSection(title: "Code Example", code: toolbarGroupCode, language: "swift")

            KeyPointsCard(points: [
                "ToolbarItemGroup groups related actions with shared glass background",
                "ToolbarSpacer(.fixed) adds fixed spacing between groups",
                "ToolbarSpacer(.flexible) adds flexible spacing that adjusts",
                "Grouping improves visual hierarchy and usability"
            ])
        }
    }

    private var toolbarGroupCode: String {
        """
        NavigationStack {
            List { /* content */ }
                .toolbar {
                    // Group of drawing tools
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Draw", systemImage: "pencil") {}
                        Button("Erase", systemImage: "eraser") {}
                        Button("Fill", systemImage: "paintbrush.fill") {}
                    }

                    // Flexible spacer
                    ToolbarSpacer(.flexible, placement: .topBarTrailing)

                    // Separate action with own glass background
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", systemImage: "checkmark") {}
                            .buttonStyle(.borderedProminent)
                    }
                }
        }
        """
    }
}

struct ToolbarGroupingLiveDemo: View, Equatable {
    var body: some View {
        List {
            ForEach(1...8, id: \.self) { item in
                Text("Content \(item)")
            }
        }
        .navigationTitle("Grouping")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Draw", systemImage: "pencil") {}
                Button("Erase", systemImage: "eraser") {}
            }

            ToolbarSpacer(.flexible, placement: .topBarTrailing)

            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {}
            }
        }
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
