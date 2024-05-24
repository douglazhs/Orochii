//
//  SearchStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI
import struct MangaDex.Manga

extension SearchStyleView {
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            if let mangas = vm.searchResult, !vm.isSearching, !mangas.isEmpty {
                loadedContent(with: mangas)
            } else {
                searchHandler()
            }
        }
    }
    
    @ViewBuilder
    func loadedContent(with mangas: [Manga]) -> some View {
        LazyVGrid(columns: columns, spacing: 20.0) {
            ForEach(mangas) { manga in
                NavigationLink(value: manga) {
                    GridCell(
                        of: manga,
                        coverURL: vm.api.buildURL(for: .cover(
                            id: manga.id,
                            fileName: vm.imgFileName(of: manga)
                        )),
                        title: vm.unwrapTitle(of: manga)
                    ) {
                        // TODO: - ADD/REMOVE from library
                        print("Context menu action")
                    }
                }
            }
        }
        .padding()
        .navigationDestination(for: Manga.self) {
            MangaView($0)
        }
    }
    
    @ViewBuilder
    func searchHandler() -> some View {
        if !vm.isSearching && isSearching {
            Text("No results found for: *\(vm.nameQuery)*")
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.ORCH.primaryText)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        } else if vm.isSearching {
            IndeterminateProgressView()
        }
    }
}
