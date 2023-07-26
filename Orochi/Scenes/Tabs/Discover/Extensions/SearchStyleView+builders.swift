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
        ScrollView {
            if let mangas = vm.searchResult, !vm.isSearching, !mangas.isEmpty {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(mangas) { manga in
                        NavigationLink {
                            MangaView(manga)
                        } label: {
                            MangaStandardImage(
                                url: vm.api.buildURL(for: .cover(
                                    id: manga.id,
                                    fileName: vm.imgFileName(of: manga)
                                )),
                                size: CGSize(
                                    width: CGSize.dynamicImage.width * 1.35,
                                    height: CGSize.dynamicImage.height * 1.35
                                )
                            )
                        }
                        .contextMenu {
                            // TODO: - Implement context menu features
                            Button { } label: {
                                Label(
                                    String.ContextMenu.addToLib,
                                    systemImage: "plus.rectangle.on.folder"
                                )
                            }
                        } preview: { MangaView(manga) }
                    }
                }
                .padding()
            } else {
                if vm.isSearching { ActivityIndicator().padding(.vertical) } else {
                    Text("NO RESULTS FOUND :(")
                        .lineLimit(1)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.systemGray))
                        .padding(.vertical)
                }
            }
        }
    }
}
