//
//  ALAccountView+favorites.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 08/03/24.
//

import Foundation
import SwiftUI
import struct AniListService.Media

extension ALAccountView {
    /// Authenticated user favorites mangas
    @ViewBuilder
    func favorites() -> some View {
        switch vm.favoritesState {
        case .loading:
            ActivityIndicator()
                .frame(maxWidth: .infinity)
        case .loaded:
            if !vm.favorites.isEmpty {
                LazyVGrid(columns: columns, spacing: 20.0) {
                    ForEach(vm.favorites, id: \.id) { manga in
                        favoriteManga(manga)
                            .onTapGesture { [weak vm] in
                                vm?.selectedManga = manga
                                vm?.webView = .manga
                            }
                    }
                }
            } else {
                Text(String.Account.noFavorites)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    /// Favorite manga card
    @ViewBuilder
    func favoriteManga(_ manga: Media) -> some View {
        VStack(alignment: .leading) {
            MangaStandardImage(
                url: URL(string: manga.coverImage?.medium ?? ""),
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
                )
            )
            
            Text(manga.title?.english ?? manga.title?.romaji ?? String.Common.unknown)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color.ORCH.primaryText)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            Text(MangaStatus(rawValue: manga.mediaListEntry?.status ?? "")?.description.uppercased() ?? "")
                .font(.caption)
                .fontWeight(.regular)
                .foregroundStyle(Color.ORCH.secondaryText)
            Spacer()
        }.frame(maxWidth: CGSize.standardImageCell.width, alignment: .top)
    }
}
