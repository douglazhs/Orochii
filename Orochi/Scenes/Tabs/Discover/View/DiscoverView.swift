//
//  DiscoverView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

/// Discover view style
enum ViewStyle {
    case search, initial
}

struct DiscoverView: View {
    @StateObject var vm = DiscoverViewModel()
    @State var viewStyle: ViewStyle = .initial
    @State var mangaSourcePref: Bool = false
    
    var body: some View {
        NavigationStack {
            content()
                .background(BlurBackground(with: .view_background))
                .navigationTitle(String.Discovery.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        mangaSourceButton()
                    }
                }
        }
        .searchable(
            text: $vm.searchText,
            placement: .navigationBarDrawer(
                displayMode: .always
            ),prompt: "Search for title"
        )
        .onSubmit(of: .search) {
            viewStyle = .search
            vm.search()
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}


