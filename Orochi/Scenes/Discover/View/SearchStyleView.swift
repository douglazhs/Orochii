//
//  SearchStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct SearchStyleView: View {
    @Environment(\.isSearching) var isSearching
    var mangas: [MangaDomain]
    @Binding var viewStyle: ViewStyle
    
    init(
        mangas: [MangaDomain],
        _ viewStyle: Binding<ViewStyle>
    ) {
        self.mangas = mangas
        self._viewStyle = viewStyle
    }
    var body: some View {
        List(mangas) { manga in
            self.cell(of: manga)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(ViewBackground(with: .view_background))
        .scrollContentBackground(.hidden)
        .onChange(of: isSearching) { newValue in
            if !newValue { viewStyle = .initial }
        }
        .animation(.spring(), value: [isSearching])
    }
}

struct SearchStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchStyleView(mangas: MangaDomain.samples, .constant(.search))
    }
}
