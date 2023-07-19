//
//  HistoryMangaCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI
import struct MangaDex.Manga

struct HistoryMangaCell: View {
    var manga: Manga
    
    init(of manga: Manga) {
        self.manga = manga
    }
    
    var body: some View {
        self.cell()
    }
}

struct HistoryMangaCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*HistoryMangaCell(of: MangaDomain.samples[0])*/
    }
}
