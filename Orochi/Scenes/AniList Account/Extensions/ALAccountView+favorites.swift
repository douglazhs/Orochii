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
        Group {
            switch vm.favoritesState {
            case .loading:
                ActivityIndicator()
                    .frame(maxWidth: .infinity)
            case .loaded:
                if !vm.favorites.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10.0) {
                            ForEach(vm.favorites, id: \.id) {
                                GridCell(
                                    coverURL: URL(
                                        string: $0.coverImage?.extraLarge
                                        ?? $0.coverImage?.large
                                        ?? $0.coverImage?.medium
                                        ?? ""
                                    ),
                                    title: $0.title?.english
                                    ?? $0.title?.romaji
                                    ?? String.Common.unknown
                                ) { print("Favorite context menu action") }
                            }
                        }.padding()
                    }
                } else {
                    noContent(message: String.Account.noFavorites)
                }
            case .failed:
                noContent(message: String.Account.noFavorites)
            }
        }.background(Color.ORCH.background)
    }
}
