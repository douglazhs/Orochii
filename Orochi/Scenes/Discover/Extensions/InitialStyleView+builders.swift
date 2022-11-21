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
        VStack {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                   width: UIScreen.width/5.5,
                   height: UIScreen.width/4
                )
            )
            Text(manga.title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(maxWidth: UIScreen.width/5.5)
                .foregroundColor(Color(uiColor: .systemGray))
            Spacer()
        }
        .frame(maxHeight: .infinity)
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
