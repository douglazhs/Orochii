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
                ForEach(vm.favorites, id: \.id) { manga in
                    Button {
                        vm.selectedManga = manga.id
                        vm.webView = .manga
                        showWebView = true
                    } label: {
                        favoriteManga(manga)
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
        HStack(alignment: .top) {
            MangaStandardImage(
                url: URL(string: manga.coverImage?.medium ?? ""),
                size: CGSize(
                    width: CGSize.standardImageCell.width * 0.7,
                    height: CGSize.standardImageCell.height * 0.7
                )
            )
            
            VStack(alignment: .leading) {
                Text(manga.title?.english ?? manga.title?.romaji ?? "")
                
                Text(MangaStatus(rawValue: manga.mediaListEntry?.status ?? "")?.description.uppercased() ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }.badge(manga.mediaListEntry?.progress ?? 0)
        }
    }
}
