//
//  SearchStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension SearchStyleView {
    @ViewBuilder
    func content() -> some View {
        if !mangas.isEmpty{
            List(mangas) { manga in
                self.cell(of: manga)
                    .listRowInsets(.init(top: 11, leading: 16, bottom: 0, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .contextMenu {
                        // TODO: - Implement context menu features
                        Button { } label: {
                            Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                        }
                    } preview: { MangaView(manga) }
            }
            .listStyle(.plain)
            .background(BlurBackground(with: .view_background))
            .scrollContentBackground(.hidden)
            .animation(.spring(), value: [isSearching])
        } else {
            // TODO: - Show empty view
        }
    }
    
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
            MangaStandardCell(manga, isSearch: true)
        }
    }
}
