//
//  LibraryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

extension LibraryView {
    /// Manga list
    /// - Returns: Filtered manga list
    @ViewBuilder
    func content() -> some View {
        List(MangaStatus.allCases) { status in
            Section(status.description.uppercased()) {
                ForEach(MangaDomain.samples) {
                    if $0.status == status {
                        cell(of: $0)
                            .listRowInsets(.init(top: 5.5, leading: 0, bottom: 5.5, trailing: 8.5))
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .contextMenu {
                                // TODO: - Context menu features
                                Button(role: .destructive) { } label: {
                                    Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .listRowInsets(.init(top: 11.0, leading: 0, bottom: 4.5, trailing: 0))
        }
        .scrollIndicators(.hidden)
        .refreshable { }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        .background(BlurBackground(with: .view_background))
        .animation(.spring(), value: [isSearching])
    }
    
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: MangaDomain) -> some View {
        ZStack {
            NavigationLink { /*MangaView(manga)*/ } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            /*MangaStandardCell(manga)*/
        }
    }
    
    /// Filter button
    /// - Returns: Filter manga results button
    @ViewBuilder
    func filterButton() -> some View {
        Menu {
            LibraryFilterView().environmentObject(vm)
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
        }
        .menuStyle(.borderlessButton)
    }
}
