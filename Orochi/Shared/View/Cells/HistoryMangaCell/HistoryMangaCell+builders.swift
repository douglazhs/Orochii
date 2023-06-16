//
//  HistoryMangaCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

extension HistoryMangaCell {
    /// All manga history information
    @ViewBuilder
    func cell() -> some View {
        HStack(alignment: .top, spacing: 7.5) {
            self.cover()
            VStack(alignment: .leading, spacing: 7.5) {
                Text(manga.title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                // WHEN
                self.time()
                Spacer()
                // READ CHAPTERS
                self.chapters()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: CGSize.standardImageCell.height
        )
    }
    
    /// Manga cover
    @ViewBuilder
    func cover() -> some View {
        Image(manga.cover)
            .resizable()
            .cornerRadius(4.5)
            .frame(
                width: CGSize.standardImageCell.width,
                height: CGSize.standardImageCell.height
            )
    }
    
    /// When the chapters was read
    @ViewBuilder
    func time() -> some View {
        Label("9:45 - 10:37", systemImage: "clock")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    /// Read chapters information
    @ViewBuilder
    func chapters() -> some View {
        HStack {
            Text("CH. 41 - 52")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text("204 pages")
                .foregroundColor(.secondary)
                .font(.caption)
        }
    }
}
