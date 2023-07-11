//
//  MangaStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaStandardCell: View {
    var manga: MangaDomain
    var isSearch: Bool
    @State var anilist: Bool = false
    
    init(_ manga: MangaDomain, isSearch: Bool = false) {
        self.manga = manga
        self.isSearch = isSearch
    }
    var body: some View {
        cell()
    }
}

struct MangaStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        MangaStandardCell(MangaDomain.samples[0])
    }
}
