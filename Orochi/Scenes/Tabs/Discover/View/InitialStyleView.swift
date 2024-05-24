//
//  InitialStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct InitialStyleView: View {
    @EnvironmentObject var vm: DiscoverViewModel
    var columns = [
        GridItem(.adaptive(minimum: CGSize.dynamicImage.width))
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            filterCarousel()
            
            discoverGrid()
        }
        .overlay(alignment: .top) {
            if vm.loading {
                IndeterminateProgressView()
            }
        }
        .navigationDestination(for: Manga.self) {
            MangaView($0)
        }
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
            .environmentObject(DiscoverViewModel())
    }
}
