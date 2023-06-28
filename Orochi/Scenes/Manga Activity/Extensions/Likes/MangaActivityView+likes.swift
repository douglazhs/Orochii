//
//  MangaActivityView+likes.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/06/23.
//

import SwiftUI
import struct AniListService.ShortUser
import Kingfisher

extension MangaActivityView {
    /// Like carousel
    @ViewBuilder
    func likesCarousel() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 5.0) {
                if let likes = vm.activity?.likes {
                    ForEach(likes.prefix(20)) { like in
                        NavigationLink {
                            AniListAccountView(like.id)
                        } label: {
                            likeCell(like.avatar?.medium ?? "")
                        }
                    }
                    if likes.count > 20 {
                        Button {
                            showLikes = true
                        } label: {
                            Circle()
                                .fill(Color(UIColor.systemGray4))
                                .overlay(alignment: .center) {
                                    Text("\(likes.count - 20)+")
                                        .font(.system(
                                            size: 8.5,
                                            weight: .semibold,
                                            design: .rounded)
                                        )
                                }
                        }
                        .tint(.white)
                        .buttonStyle(.borderless)
                        .padding(.leading, 5.0)
                        .sheet(isPresented: $showLikes) {
                            List(likes) {
                                Text($0.name ?? "")
                            }
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
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .resizable()
                .scaledToFill()
                .frame(
                    width: CGSize.standardImageCell.width * 0.45,
                    height: CGSize.standardImageCell.width * 0.45
                )
                .clipShape(Circle())
        }
    }
}
