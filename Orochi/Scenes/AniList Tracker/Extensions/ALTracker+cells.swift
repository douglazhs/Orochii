//
//  ALTracker+cells.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI
import struct AniListService.Media

extension ALTracker {
    /// AniList manga cell
    @ViewBuilder
    func mangaCell(_ manga: Media) -> some View {
        HStack(alignment: .top, spacing: 10) {
            MangaStandardImage(
                url: URL(string: manga.coverImage?.large ?? ""),
                size: CGSize.standardImageCell
            )
            
            VStack(alignment: .leading, spacing: 3.5) {
                Text(manga.title?.romaji ?? "Unknown")
                    .lineLimit(2)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text("\(manga.title?.english ?? "No english title")")
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10.0, height: 10.0)
                    Text("\((manga.averageScore ?? 0) / 10)")
                        .font(.caption2)
                }
                if manga.mediaListEntry != nil {
                    Text("~ **\(manga.mediaListEntry?.status ?? "")** ~ ON YOUR LIST")
                        .font(.caption2)
                        .foregroundColor(Color(.systemGray))
                        .fontWeight(.regular)
                }
                Text(manga.status ?? "")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)
    }
}
