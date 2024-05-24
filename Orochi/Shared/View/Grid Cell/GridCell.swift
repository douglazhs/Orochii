//
//  GridCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/24.
//

import SwiftUI
import struct MangaDex.Manga
import class MangaDex.MangaMock

struct GridCell: View {
    var manga: Manga
    var coverURL: URL?
    var title: String
    var mangaOnLibrary: Bool
    var action: () -> Void
    
    init(
        of manga: Manga,
        coverURL: URL?,
        title: String,
        mangaOnLibrary: Bool = false,
        action: @escaping () -> Void
    ) {
        self.manga = manga
        self.coverURL = coverURL
        self.title = title
        self.mangaOnLibrary = mangaOnLibrary
        self.action = action
    }
    
    var body: some View {
        MangaStandardImage(
            url: coverURL,
            size: CGSize(
                width: CGSize.dynamicImage.width,
                height: CGSize.dynamicImage.height
            )
        )
        .overlay(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.clear, Color.ORCH.background], startPoint: .center, endPoint: .bottom)
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(1)
                    .padding(7.5)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 6.5))
            .zIndex(1)
        }
        .contextMenu {
            Section {
                Button { action() } label: {
                    Label(
                        mangaOnLibrary
                        ? String.ContextMenu.rmvFromLib
                        : String.ContextMenu.addToLib,
                        systemImage: mangaOnLibrary
                        ? "trash"
                        : "plus.rectangle.on.folder"
                    )
                }
                .tint(mangaOnLibrary ? .red : .primary)
            } header: {
                Text(title)
            }
        }
    }
}

#Preview {
    GridCell(
        of: MangaMock.manga,
        coverURL: MangaMock.coverUrl,
        title: MangaMock.manga.attributes?.title?.en 
        ?? MangaMock.manga.attributes?.title?.jaRo
        ?? ""
    ) { }
}
