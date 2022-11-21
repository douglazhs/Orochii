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
        List(MangaDomain.samples) { manga in
            self.cell(of: manga)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(name: "aesthetic"))
        .onChange(of: isSearching) { newValue in
            if !newValue {
                // TODO: - Clear search
            }
        }
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
        }
        .contextMenu {
            // TODO: - Implement context menu features
            Button { } label: {
                Label(String.Discovery.addToLib, systemImage: "plus.rectangle.on.folder")
            }
            Button(role: .destructive) { } label: {
                Label(String.Discovery.remFromLib, systemImage: "trash")
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
