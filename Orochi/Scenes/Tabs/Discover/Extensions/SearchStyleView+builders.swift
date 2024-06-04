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
            if !vm.history.isEmpty { searchHistory() }
            if let mangas = vm.searchResult {
                loadedContent(with: mangas)
            }
        }
        .overlay(alignment: .top) {
            if vm.isSearching {
                IndeterminateProgressView()
            }
        }
    }
    
    /// Search history carousel
    @ViewBuilder
    func searchHistory() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 7.5) {
                ForEach(vm.history.indices, id: \.self) { index in
                    Button {
                        vm.fillWithHistory(on: index)
                    } label: {
                        HStack {
                            Text(vm.history[index])
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Button {
                                vm.removeQuery(on: index)
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .font(.footnote)
                            }
                        }
                    }
                    .tint(Color.ORCH.primaryText)
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    
                }
            }.padding([.horizontal, .top])
        }
    }
    
    @ViewBuilder
    func loadedContent(with mangas: [Manga]) -> some View {
        LazyVGrid(columns: columns, spacing: 10.0) {
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
        }
    }
}
