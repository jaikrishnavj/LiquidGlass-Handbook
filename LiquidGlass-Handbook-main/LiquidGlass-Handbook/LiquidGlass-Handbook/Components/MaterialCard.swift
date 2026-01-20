//
//  MaterialCard.swift
//  LiquidGlass-Handbook
//
//  Created by Jaikrishna on 12/12/25.
//

import SwiftUI

struct MaterialCard: View, Equatable {
    let material: Material
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 12))
    }

    static func == (lhs: MaterialCard, rhs: MaterialCard) -> Bool {
        lhs.title == rhs.title
    }
}
