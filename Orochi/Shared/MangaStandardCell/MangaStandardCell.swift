//
//  MangaStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaStandardCell: View {
    var manga: MangaDomain
    
    init(_ manga: MangaDomain) {
        self.manga = manga
    }
    var body: some View {
        self.cell()
    }
}

struct MangaStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        MangaStandardCell(samples[0])
    }
}
