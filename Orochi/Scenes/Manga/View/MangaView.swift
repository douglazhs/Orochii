//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaView: View {
    var manga: MangaDomain
    
    init(_ manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        self.content()
            .navigationTitle(manga.title)
//            .navigationBarTitleDisplayMode(.inline)
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(samples[0])
    }
}
