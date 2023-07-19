//
//  SearchStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct SearchStyleView: View {
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var vm: DiscoverViewModel
    var mangas: [Manga]?
    @Binding var viewStyle: ViewStyle
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(
        mangas: [Manga]?,
        _ viewStyle: Binding<ViewStyle>
    ) {
        self.mangas = mangas
        self._viewStyle = viewStyle
    }
    var body: some View {
        self.content()
            .animation(.spring())
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    viewStyle = .initial
                    vm.searchResult = nil
                }
            }
    }
}

struct SearchStyleView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*SearchStyleView(mangas: MangaDomain.samples, .constant(.search))*/
    }
}
