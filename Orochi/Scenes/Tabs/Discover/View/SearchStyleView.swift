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
        self.content()
            .onChange(of: isSearching) { newValue in
                if !newValue { viewStyle = .initial }
            }
    }
}

struct SearchStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchStyleView(mangas: MangaDomain.samples, .constant(.search))
    }
}
