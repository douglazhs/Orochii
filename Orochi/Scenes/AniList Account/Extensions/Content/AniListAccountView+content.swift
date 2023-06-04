//
//  AniListAccountView+content.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI
import AniListService

extension AniListAccountView {
    @ViewBuilder
    func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                self.statsCell()
                self.tabs()
            }
        }
        .refreshable { vm.fetch(isRefresh: true) }
        .background(BlurBackground(with: .view_background))
        .scrollContentBackground(.hidden)
    }
}
