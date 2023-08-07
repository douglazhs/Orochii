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
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(mangas) { manga in
                        NavigationLink(value: manga) {
                            cell(of: manga)
                        }
                        .contextMenu {
                            Button { } label: {
                                Label(
                                    String.ContextMenu.addToLib,
                                    systemImage: "plus.rectangle.on.folder"
                                )
                            }
                        }
                    }
                }
                .padding()
                .navigationDestination(for: Manga.self) {
                    MangaView($0)
                }
            } else {
                if vm.isSearching {
                    ActivityIndicator().padding(.vertical)
                } else if !vm.isSearching {
                    Text("No results found for: *\(vm.nameQuery)*")
                        .lineLimit(1)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.systemGray))
                        .padding(.vertical)
                }
            }
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
                width: CGSize.dynamicImage.width * 1.25,
                height: CGSize.dynamicImage.height * 1.25
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
                    .fontWeight(.semibold)
                    .foregroundColor(.primary.opacity(0.85))
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.5))
        }
    }
}
