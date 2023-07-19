//
//  InitialStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import MangaDex

extension InitialStyleView {
    /// Carousel
    /// - Parameter mangas: Retrieved mangas
    @ViewBuilder
    func carousel(of mangas: [Manga]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(mangas) { manga in
                    NavigationLink {
                        MangaView(manga)
                    } label: {
                        cell(of: manga)
                            .contextMenu {
                                // TODO: - Implement context menu features
                                Button { } label: {
                                    Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                                }
                                Button(role: .destructive) { } label: {
                                    Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 3.5)
        }
    }
    
    /// Manga carousel cell
    /// - Parameter manga: Current manga
    @ViewBuilder
    func cell(of manga: Manga) -> some View {
        VStack(alignment: .leading, spacing: 2.5) {
            MangaStandardImage(
                url: vm.api.buildURL(for: .cover(id: manga.id, fileName: vm.fileName(of: manga))),
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
                )
            )
            Text(manga.attributes?.title?.en ?? "")
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.system(.footnote, design: .none, weight: .regular))
                .foregroundColor(.primary.opacity(0.75))
                .frame(
                    width: CGSize.standardImageCell.width,
                    alignment: .leading
                )
        }
    }
}
