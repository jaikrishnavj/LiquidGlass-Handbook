//
//  ToolbarGlassDemo.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct ToolbarGlassDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DemoSection(title: "Live Demo") {
                ToolbarGlassLiveDemo()
            }

            ActionButtonsCard(
                title: "Toolbar Liquid Glass",
                description: "Toolbar buttons with .glass button style create beautiful translucent effects. The principal placement supports menus with glass style for modern navigation patterns. This demo shows selection mode with dynamic toolbar updates: tap Select to choose items, then use Star or Delete buttons that appear conditionally.",
                keyPoints: [
                    "Toolbar buttons support .glass button style",
                    "Principal placement supports Menu with .glass style",
                    "Selection mode shows checkmarks alongside stars",
                    "Star and Delete buttons appear only when items selected",
                    "Tap stars directly to favorite when not selecting",
                    "Conditional toolbar items create dynamic UI"
                ],
                code: toolbarGlassCode,
                icon: "menubar.rectangle",
                color: .blue
            )
        }
    }

    private var toolbarGlassCode: String {
        """
        NavigationStack {
            List {
                ForEach(items, id: \\.self) { item in
                    HStack(spacing: 12) {
                        // Selection circle (shows in selection mode)
                        if isSelecting {
                            Image(systemName: selectedItems.contains(item)
                                ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(selectedItems.contains(item)
                                    ? .blue : .gray.opacity(0.5))
                                .onTapGesture { toggleSelection(item) }
                        }

                        // Star (always visible)
                        Image(systemName: starredItems.contains(item)
                            ? "star.fill" : "star")
                            .foregroundStyle(starredItems.contains(item)
                                ? .yellow : .gray)
                            .onTapGesture {
                                if !isSelecting { toggleStar(item) }
                            }

                        Text("Item \\(item)")
                    }
                }
            }
            .toolbar {
                // Principal - Menu with glass style
                ToolbarItem(placement: .principal) {
                    Menu {
                        Button("Sort Ascending", systemImage: "arrow.up") { }
                        Button("Sort Descending", systemImage: "arrow.down") { }
                        Divider()
                        Button("Select All", systemImage: "checkmark.circle.fill") { }
                    } label: {
                        Text("Options")
                    }
                    .buttonStyle(.glass)
                }

                // Trailing - Select button
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isSelecting ? "Done" : "Select",
                           systemImage: "checkmark.circle") { }
                }

                // Show when items are selected
                if isSelecting && !selectedItems.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Star", systemImage: "star.fill") { }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Delete", systemImage: "trash") { }
                    }
                }
            }
        }
        """
    }
}

struct ToolbarGlassLiveDemo: View {
    @State private var isSelecting = false
    @State private var selectedItems: Set<Int> = []
    @State private var showShareSheet = false
    @State private var starredItems: Set<Int> = []
    @State private var items = Array(1...10)
    @State private var sortOrder: SortOrder = .ascending
    @State private var showDeleteAlert = false

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(sortedItems, id: \.self) { item in
                    HStack(spacing: 12) {
                        if isSelecting {
                            Image(systemName: selectedItems.contains(item) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(selectedItems.contains(item) ? .blue : .gray.opacity(0.5))
                                .font(.system(size: 22))
                                .onTapGesture {
                                    toggleSelection(item)
                                }
                        }

                        Image(systemName: starredItems.contains(item) ? "star.fill" : "star")
                            .foregroundStyle(starredItems.contains(item) ? .yellow : .gray)
                            .font(.system(size: 20))
                            .onTapGesture {
                                if !isSelecting {
                                    toggleStar(item)
                                }
                            }

                        Text("Item \(item)")
                            .onTapGesture {
                                if isSelecting {
                                    toggleSelection(item)
                                }
                            }
                    }
                }
            }
            .navigationTitle("Toolbar Demo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Menu {
                        Button(action: { sortOrder = .ascending }) {
                            Label("Sort Ascending", systemImage: "arrow.up")
                        }

                        Button(action: { sortOrder = .descending }) {
                            Label("Sort Descending", systemImage: "arrow.down")
                        }

                        Divider()

                        Button(action: { selectAll() }) {
                            Label("Select All", systemImage: "checkmark.circle.fill")
                        }

                        Button(action: { selectedItems.removeAll() }) {
                            Label("Deselect All", systemImage: "circle")
                        }
                    } label: {
                        Text("Options")
                    }
                    .buttonStyle(.glass)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        toggleSelecting()
                    }) {
                        Label(isSelecting ? "Done" : "Select",
                              systemImage: isSelecting ? "checkmark" : "checkmark.circle")
                    }
                }

                if isSelecting && !selectedItems.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            starSelectedItems()
                        }) {
                            Label("Star", systemImage: "star.fill")
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }

                if !isSelecting {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showShareSheet = true
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .sheet(isPresented: $showShareSheet) {
            ShareSheetDemo()
        }
        .alert("Delete Selected Items", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteSelectedItems()
            }
        } message: {
            Text("Are you sure you want to delete \(selectedItems.count) selected item(s)?")
        }
    }

    private var sortedItems: [Int] {
        sortOrder == .ascending ? items.sorted() : items.sorted(by: >)
    }

    private func toggleSelection(_ item: Int) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }

    private func toggleStar(_ item: Int) {
        if starredItems.contains(item) {
            starredItems.remove(item)
        } else {
            starredItems.insert(item)
        }
    }

    private func toggleSelecting() {
        isSelecting.toggle()
        if !isSelecting {
            selectedItems.removeAll()
        }
    }

    private func starSelectedItems() {
        starredItems.formUnion(selectedItems)
        selectedItems.removeAll()
        isSelecting = false
    }

    private func deleteSelectedItems() {
        items.removeAll { selectedItems.contains($0) }
        starredItems.subtract(selectedItems)
        selectedItems.removeAll()
        isSelecting = false
    }

    private func selectAll() {
        selectedItems = Set(items)
        if !isSelecting {
            isSelecting = true
        }
    }

    private enum SortOrder {
        case ascending, descending
    }
}

private struct ShareSheetDemo: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("Share Demo")
                    .font(.title.bold())

                Text("This is a demo share sheet")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Share")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
