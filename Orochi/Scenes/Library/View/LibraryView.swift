//
//  LibraryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.isSearching) var isSearching
    var device = UIDevice.current.userInterfaceIdiom
    @StateObject var vm: LibraryViewModel = LibraryViewModel()
    @State var showFilters: Bool = false
    
    var body: some View {
        NavigationStack {
            self.content()
                .onChange(of: isSearching) { newValue in
                    print("Clear Filter!")
                    if !newValue {
                        // TODO: - Clear search
                    }
                }
                .navigationTitle(String.Library.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    device == .phone ? .visible : .automatic,
                    for: .navigationBar
                )
                .toolbarBackground(
                    Color.indigo.opacity(0.075),
                    for: .navigationBar
                )
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        self.filterButton()
                    }
                }
        }
        .searchable(text: $vm.query)
        .onSubmit(of: .search) {
            // TODO: - Search
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
