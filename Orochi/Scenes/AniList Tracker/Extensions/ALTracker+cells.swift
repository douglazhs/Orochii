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
            .overlay {
                ZStack(alignment: .top) {
                    LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .center)
                    Text(
                        manga.averageScore != nil
                        ? String(format: "%.1f", Double(manga.averageScore ?? 0) / 10.0)
                        : manga.averageScore.nilToStr
                    )
                    .font(.system(size: 9.5, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(3.25)
                    .foregroundColor(Color("bodyText"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 4.5))
            }
            
            VStack(alignment: .leading, spacing: 3.5) {
                Text(manga.title?.romaji ?? "Unknown")
                    .lineLimit(2)
                    .font(.subheadline)
                    .fontWeight(.medium)
                if let english = manga.title?.english {
                    Text(english)
                        .lineLimit(1)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(Color("secondaryText"))
                }
                Text(manga.format.notEmpty)
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color("bodyText"))
                Text(manga.status.notEmpty)
                    .font(.caption2)
                    .foregroundColor(Color("bodyText"))
                if let status = manga.mediaListEntry?.status {
                    Text("**\((MangaStatus(rawValue: status) ?? .planning).description.uppercased())**")
                        .font(.caption2)
                        .foregroundColor(.accentColor)
                        .fontWeight(.regular)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)
    }
}
