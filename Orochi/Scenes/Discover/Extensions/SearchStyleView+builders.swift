//
//  SearchStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension SearchStyleView {
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: MangaDomain) -> some View {
        ZStack {
            NavigationLink { MangaView(manga) } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            MangaStandardCell(manga)
        }
        .contextMenu {
            // TODO: - Implement context menu features
            Button { } label: {
                Label(String.Discovery.addToLib, systemImage: "plus.rectangle.on.folder")
            }
            Button(role: .destructive) { } label: {
                Label(String.Discovery.remFromLib, systemImage: "trash")
            }
        }
    }
}
