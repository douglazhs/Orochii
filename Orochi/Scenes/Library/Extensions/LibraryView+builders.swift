//
//  LibraryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension LibraryView {
    /// Manga list
    /// - Returns: Filtered manga list
    @ViewBuilder
    func content() -> some View {
        List {
            ForEach(MangaDomain.samples) { manga in
                self.cell(of: manga)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .leading) {
                        //Edit
                        Label ("AniList", systemImage: "pencil")
                    }
                    .swipeActions(edge: .trailing) {
                        // Delete
                        Label("Remove", systemImage: "trash")
                    }
                    .contextMenu {
                        // TODO: - Implement context menu features
                        Button(role: .destructive) { } label: {
                            Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                        }
                    } preview: { MangaView(manga) }
            }
            .onDelete { _ in
                
            }
        }
        .refreshable {
            // TODO: Refresh library mangas
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(with: .view_background))
        .animation(.spring(), value: [isSearching])
    }
    
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: MangaDomain) -> some View {
        ZStack {
            NavigationLink { MangaView(manga) } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            MangaStandardCell(manga)
                .overlay(alignment: .topTrailing) {
                    if manga.hasUpdate {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(
                                maxWidth: 7.5,
                                maxHeight: 7.5
                            )
                            .foregroundColor(.orange)
                            .padding(.top, 7.5)
                    }
                }
        }
    }
    
    /// Filter button
    /// - Returns: Filter manga results button
    @ViewBuilder
    func filterButton() -> some View {
        Button { showFilters = true } label: {
            Image(systemName: "line.3.horizontal.decrease")
        }
        .sheet(isPresented: $showFilters) {
            LibraryFilterView().environmentObject(vm)
                .presentationDetents([.medium, .large])
        }
    }
}
