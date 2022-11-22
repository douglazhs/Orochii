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
    /// - Returns: Carousel of mangas
    @ViewBuilder func carousel(of mangas: [MangaDomain]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(mangas) { manga in
                    NavigationLink {
                        MangaView(manga)
                    } label: { self.cell(of: manga) }
                }
            }
            .padding(.horizontal)
        }
    }
    
    /// Manga carousel cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom carousel manga cell
    @ViewBuilder func cell(of manga: MangaDomain) -> some View {
        let portrait = UIScreen.width < UIScreen.height
        let aspectRatio = 97.5 / 67.5
        let width = (portrait ? UIScreen.width : UIScreen.height) * 0.215
        VStack {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: width,
                    height: width
                ),
                aspectRatio: aspectRatio
            )
            Text(manga.title)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: width)
                .foregroundColor(Color(uiColor: .systemGray))
            Spacer()
        }
        .frame(maxHeight: .infinity)
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
