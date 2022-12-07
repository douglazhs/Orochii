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
    @EnvironmentObject var router: Router
    @StateObject var vm = DiscoverViewModel()
    @State var viewStyle: ViewStyle = .initial
    @State var mangaSourcePref: Bool = false
    var body: some View {
        NavigationStack(path: $router.path) {
            self.content()
                .navigationTitle(Text(String.Discovery.title))
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    Constants.device == .phone ? .visible : .automatic,
                    for: .navigationBar
                )
                .toolbarBackground(
                    Color.indigo.opacity(0.075),
                    for: .navigationBar
                )
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
        DiscoverView().environmentObject(Router())
    }
}


