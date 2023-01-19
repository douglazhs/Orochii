//
//  InitialStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension InitialStyleView {
    /// Carousel
    /// - Parameter mangas: Retrieved mangas
    @ViewBuilder
    func carousel(of mangas: [MangaDomain]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(mangas) { manga in
                    NavigationLink {
                        MangaView(manga)
                    } label: {
                        self.cell(of: manga)
                            .contextMenu {
                                // TODO: - Implement context menu features
                                Button { } label: {
                                    Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                                }
                                Button(role: .destructive) { } label: {
                                    Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                                }
                            } preview: { MangaView(manga) }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
    
    /// Manga carousel cell
    /// - arameter manga: Current manga
    @ViewBuilder
    func cell(of manga: MangaDomain) -> some View {
        VStack(spacing: 2.5) {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
                )
            ).frame(height: CGSize.standardImageCell.height)
            Text(manga.title)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.system(.footnote, design: .none, weight: .regular))
                .foregroundColor(.primary.opacity(0.75))
                .frame(maxWidth: CGSize.standardImageCell.width)
        }
    }
}
