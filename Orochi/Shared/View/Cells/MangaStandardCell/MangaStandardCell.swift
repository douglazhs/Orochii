//
//  MangaStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct MangaStandardCell: View {
    var manga: Manga
    var isSearch: Bool
    @State var anilist: Bool = false
    
    init(_ manga: Manga, isSearch: Bool = false) {
        self.manga = manga
        self.isSearch = isSearch
    }
    var body: some View {
        cell()
    }
}

struct MangaStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
