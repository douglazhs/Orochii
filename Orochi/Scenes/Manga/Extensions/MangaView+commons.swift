//
//  MangaView+commons.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension MangaView {
    /// Manga information line
    /// - Parameters:
    ///   - leading: Leading item
    ///   - trailing: Trailing item
    @ViewBuilder
    func infoLine(
        leading: (String, String),
        trailing: (String, String)
    ) -> some View {
        HStack {
            self.item(title: leading.0, leading.1, .leading)
            Spacer()
            self.item(title: trailing.0, trailing.1, .trailing)
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
