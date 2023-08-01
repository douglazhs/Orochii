//
//  MediaAttributes+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI

extension MediaAttributes {
    /// Manga information line
    /// - Parameters:
    ///   - leading: Leading item
    ///   - trailing: Trailing item
    @ViewBuilder
    func infoLine(
        leading: (title: String, value: String),
        trailing: (title: String, value: String)
    ) -> some View {
        HStack {
            self.item(title: leading.title, leading.value, .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            self.item(title: trailing.title, trailing.value, .trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    /// Manga information item
    /// - Parameters:
    ///   - title: Manga title
    ///   - description: Manga item
    ///   - alignment: Item alignment
    @ViewBuilder
    func item(
        title: String,
        _ description: String,
        _ alignment: HorizontalAlignment
    ) -> some View {
        VStack(alignment: alignment, spacing: 2.5) {
            Text(title)
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 2.25,
                    x: 1.0,
                    y: 1.0
                )
            Text(description)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}
