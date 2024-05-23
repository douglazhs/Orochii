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
                loadingContent()
            }
        }
    }
    
    @ViewBuilder
    func loadedContent(with mangas: [Manga]) -> some View {
        LazyVGrid(columns: columns, spacing: 20.0) {
            ForEach(mangas) { manga in
                NavigationLink(value: manga) {
                    cell(of: manga)
                }
                .contextMenu {
                    Section {
                        Button { } label: {
                            Label(
                                String.ContextMenu.addToLib,
                                systemImage: "plus.rectangle.on.folder"
                            )
                        }
                    } header: {
                        Text(vm.unwrapTitle(of: manga))
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
    func loadingContent() -> some View {
        if vm.isSearching {
            ActivityIndicator()
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        } else if !vm.isSearching {
            Text("No results found for: *\(vm.nameQuery)*")
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.ORCH.primaryText)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        }
    }
    
    /// Cell of grid
    @ViewBuilder
    func cell(of manga: Manga) -> some View {
        MangaStandardImage(
            url: vm.api.buildURL(for: .cover(
                id: manga.id,
                fileName: vm.imgFileName(of: manga)
            )),
            size: CGSize(
                width: CGSize.dynamicImage.width,
                height: CGSize.dynamicImage.height
            )
        )
        .overlay(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                Text(vm.unwrapTitle(of: manga))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(1)
                    .padding(7.5)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.5))
        }
    }
}
