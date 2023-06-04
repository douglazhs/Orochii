//
//  AniListAccountView+images.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension AniListAccountView {
    /// User banner
    @ViewBuilder
    func banner() -> some View {
        if let url = URL(string: vm.user?.bannerImage ?? "") {
            AsyncCacheImage(
                url: url,
                placeholder: { BlurBackground(with: .view_background) }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
            .scaledToFill()
            .blendMode(.overlay)
        } else { BlurBackground(with: .view_background) }
    }
    
    /// User avatar
    @ViewBuilder
    func avatar() -> some View {
        if let url = URL(string: vm.user?.avatar?.large ?? "") {
            AsyncCacheImage(
                url: url,
                placeholder: { ActivityIndicator() }
            ) { image in
                    Image(uiImage: image)
                        .resizable()
            }
            .cornerRadius(4.5)
        }
    }
}
