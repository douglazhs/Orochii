//
//  MangaActivityView+likes.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/06/23.
//

import SwiftUI
import struct AniListService.ShortUser

extension MangaActivityView {
    /// Like carousel
    @ViewBuilder
    func likesCarousel() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                if let likes = vm.activity?.likes {
                    ForEach(likes) { like in
                        NavigationLink {
                            AniListAccountView(like.id)
                        } label: {
                            likeCell(like.avatar?.large ?? "")
                        }
                    }
                }
            }.padding(.horizontal)
        }
    }
    
    /// Like cell
    @ViewBuilder
    func likeCell(_ url: String) -> some View {
        if let url = URL(string: url) {
            AsyncCacheImage(
                url: url,
                placeholder: { ActivityIndicator() }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
            .frame(
                width: CGSize.standardImageCell.width * 0.45,
                height: CGSize.standardImageCell.width * 0.45
            )
            .clipShape(Circle())
        }
    }
}
