//
//  LibraryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.isSearching) var isSearching
    @StateObject var vm: LibraryViewModel = LibraryViewModel()
    @State var showFilters: Bool = false
    
    var body: some View {
        NavigationStack {
            content()
                .onChange(of: isSearching) { newValue in
                    if !newValue {
                        // TODO: - Clear search
                    }
                }
                .navigationTitle(String.Library.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        filterButton()
                    }
                }
        }
        .searchable(
            text: $vm.query,
            placement: .navigationBarDrawer(
                displayMode: .always
            )
        )
        .onSubmit(of: .search) { }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
