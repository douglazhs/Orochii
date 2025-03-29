//
//  ALAccountView+favorites.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 08/03/24.
//

import Foundation
import SwiftUI
import struct AniListService.Media
import struct AniListService.Character

extension ALAccountView {
    /// Authenticated user favorites mangas
    @ViewBuilder
    func favorites() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15.0) {
                mangas()
                characters()
                staff()
            }
        }.background(Asset.Colors.background.swiftUIColor)
    }
    
    @ViewBuilder
    func mangas() -> some View {
        if !vm.favoriteMangas.isEmpty {
            VStack(alignment: .leading) {
                Text("MANGAS")
                    .font(.footnote)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
                    .padding([.horizontal, .top])
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10.0) {
                        ForEach(vm.favoriteMangas, id: \.id) {
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
                            ) { print("Favorite manga context menu action") }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 7.5)
                }
            }
        }
    }

    @ViewBuilder
    func characters() -> some View {
        if !vm.favoriteChars.isEmpty {
            VStack(alignment: .leading) {
                Text("CHARACTERS")
                    .font(.footnote)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10.0) {
                        ForEach(vm.favoriteChars, id: \.id) { char in
                            NavigationLink {
                                CharacterView(char)
                                    .environmentObject(vm)
                            } label: {
                                GridCell(
                                    coverURL: URL(string: char.image?.large ?? char.image?.medium ?? ""),
                                    title: char.name?.full ?? char.name?.first ?? String.Common.unknown
                                ) {
                                    print("Favorite character context menu action")
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 7.5)
                }
            }
        }
    }
    
    @ViewBuilder
    func staff() -> some View {
        if !vm.favoriteStaff.isEmpty {
            VStack(alignment: .leading) {
                Text("STAFF")
                    .font(.footnote)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10.0) {
                        ForEach(vm.favoriteStaff, id: \.id) { staff in
                            GridCell(
                                coverURL: URL(string: staff.image?.large ?? staff.image?.medium ?? ""),
                                title: staff.name?.full ?? staff.name?.first ?? String.Common.unknown
                            ) {
                                print("Favorite staff context menu action")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 7.5)
                }
            }
        }
    }
}
