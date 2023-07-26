//
//  SearchStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import Combine
import struct MangaDex.Manga

struct SearchStyleView: View {
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var vm: DiscoverViewModel
    @Binding var viewStyle: ViewStyle
    let columns = [
        GridItem(.adaptive(minimum: CGSize.dynamicImage.width), spacing: 5),
        GridItem(.adaptive(minimum: CGSize.dynamicImage.width), spacing: 5)
    ]
    
    init(_ viewStyle: Binding<ViewStyle>) {
        self._viewStyle = viewStyle
    }
    
    var body: some View {
        self.content()
            .onReceive(
                vm.$nameQuery
                    .debounce(for: .seconds(0.65), scheduler: DispatchQueue.main)
            ) { _ in
                vm.search()
            }
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    withAnimation(.easeInOut(duration: 0.175)) {
                        viewStyle = .initial
                        vm.searchResult = nil
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SearchStyleView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*SearchStyleView(mangas: MangaDomain.samples, .constant(.search))*/
    }
}
