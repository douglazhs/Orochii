//
//  HistoryMangaCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

struct HistoryMangaCell: View {
    var manga: MangaDomain
    var truncated: Binding<Bool>
    
    init(of manga: MangaDomain, truncated: Binding<Bool>) {
        self.manga = manga
        self.truncated = truncated
    }
    
    var body: some View {
        self.cell()
            .overlay(alignment: .bottomTrailing) {
                self.showChaptersButton()
            }
    }
}

struct HistoryMangaCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMangaCell(
            of: MangaDomain.samples[0],
            truncated: .constant(false)
        )
    }
}
