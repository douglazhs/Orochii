//
//  AniListAccountView+images.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI
import Kingfisher

extension AniListAccountView {
    /// User banner
    @ViewBuilder
    func banner() -> some View {
        if let url = URL(string: vm.user?.bannerImage ?? "") {
            KFImage.url(url)
                .placeholder({ BlurBackground(with: .view_background) })
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .forceTransition()
                .startLoadingBeforeViewAppear()
                .resizable()
                .scaledToFill()
                .blendMode(.overlay)
        } else { BlurBackground(with: .view_background) }
    }
    
    /// User avatar
    @ViewBuilder
    func avatar() -> some View {
        if let url = URL(string: vm.user?.avatar?.large ?? ""),
           let mediumUrl = URL(string: vm.user?.avatar?.medium ?? "") {
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .forceTransition()
                .startLoadingBeforeViewAppear()
                .lowDataModeSource(.network(mediumUrl))
                .resizable()
                .scaledToFit()
                .cornerRadius(4.5)
        }
    }
}
