//
//  CoverList+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 05/06/24.
//

import SwiftUI

extension CoverList {
    @ViewBuilder
    func blurBackground() -> some View {
        BlurBackground(
            with: vm.api.buildURL(
                for: .cover(
                    id: vm.manga.id,
                    fileName: vm.imgFileName(
                        of: vm.manga,
                        quality: vm.mDexCoverQuality.key
                    )
                )
            ),
            radius: 100,
            opacity: 0.825
        )
    }
}
