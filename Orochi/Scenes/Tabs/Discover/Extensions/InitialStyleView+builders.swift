//
//  InitialStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import MangaDex

extension InitialStyleView {
    /// Carousel
    /// - Parameter mangas: Retrieved mangas
    @ViewBuilder
    func carousel(_ carousel: Int, with mangas: [Manga]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(mangas) { manga in
                    NavigationLink {
                        MangaView(manga)
                    } label: {
                        cell(of: manga)
                            .task { [weak vm] in
                                if (vm?.hasReachedEnd(of: manga, on: carousel) ?? false) {
                                    vm?.fetchMore(on: carousel)
                                }
                            }
                            .contextMenu {
                                Button { } label: {
                                    Label(String.ContextMenu.addToLib, systemImage: "plus.rectangle.on.folder")
                                }
                                Button(role: .destructive) { } label: {
                                    Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    /// Manga carousel cell
    /// - Parameter manga: Current manga
    @ViewBuilder
    func cell(of manga: Manga) -> some View {
        VStack(alignment: .leading, spacing: 2.5) {
            MangaStandardImage(
                url: vm.api.buildURL(for: .cover(
                    id: manga.id,
                    fileName: vm.imgFileName(of: manga)
                )),
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
                )
            )
            Text(vm.unwrapTitle(of: manga))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(Color("bodyText"))
                .frame(
                    maxWidth: CGSize.standardImageCell.width,
                    idealHeight: 35,
                    alignment: .leading
                )
        }
    }
}
