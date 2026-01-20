//
//  Chapter.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct Chapter: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
}

extension Chapter: Hashable {
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Chapter: Equatable {}
