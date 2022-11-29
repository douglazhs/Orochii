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
    var device = UIDevice.current.userInterfaceIdiom
    @State var viewStyle: ViewStyle = .initial
    @State var mangaSourcePref: Bool = false
    var body: some View {
        NavigationStack {
            self.content()
                .navigationTitle(Text(String.Discovery.title))
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(device == .phone ? .visible : .hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        self.mangaSourceButton()
                    }
                }
        }
        .searchable(text: $vm.searchText)
        .onSubmit(of: .search) { viewStyle = .search }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}


