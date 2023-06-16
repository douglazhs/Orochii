//
//  HistoryMangaCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

struct HistoryMangaCell: View {
    var manga: MangaDomain
    
    init(of manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        self.cell()
    }
}

struct HistoryMangaCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMangaCell(of: MangaDomain.samples[0])
    }
}
