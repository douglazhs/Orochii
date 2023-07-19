//
//  SearchStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

extension SearchStyleView {
    @ViewBuilder
    func content() -> some View {
        if let mangas {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(mangas) { manga in
                        NavigationLink {
                            MangaView(manga)
                        } label: {
                            MangaStandardImage(
                                url: vm.api.buildURL(for: .cover(
                                    id: manga.id,
                                    fileName: vm.fileName(of: manga)
                                )),
                                size: CGSize(
                                    width: CGSize.dynamicImage.width * 1.25,
                                    height: CGSize.dynamicImage.height * 1.25
                                )
                            )
                        }
                        .contextMenu {
                            // TODO: - Implement context menu features
                            Button { } label: {
                                Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                            }
                        } preview: { MangaView(manga) }
                        /*self.cell(of: manga)
                         .listRowInsets(.init(top: 11, leading: 16, bottom: 0, trailing: 16))
                         .listRowBackground(Color.clear)
                         .listRowSeparator(.hidden)
                         .listSectionSeparator(.hidden)
                         .contextMenu {
                         // TODO: - Implement context menu features
                         Button { } label: {
                         Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                         }
                         } preview: { MangaView(manga) }*/
                    }
                }
            }
            /*List(mangas) { manga in
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
            .scrollContentBackground(.hidden)*/
            .animation(.spring(), value: [isSearching])
        } else {
            // TODO: - Show empty view
        }
    }
    
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: Manga) -> some View {
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
