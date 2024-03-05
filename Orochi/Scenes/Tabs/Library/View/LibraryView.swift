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
            prompt: String.Library.searchPlaceholder
        )
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
