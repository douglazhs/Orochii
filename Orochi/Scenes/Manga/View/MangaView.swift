//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaView: View {
    var manga: MangaDomain
    @StateObject var vm: MangaViewModel = MangaViewModel()
    
    init(_ manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        self.content()
            .navigationTitle(manga.title)
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(MangaDomain.samples[0])
    }
}
