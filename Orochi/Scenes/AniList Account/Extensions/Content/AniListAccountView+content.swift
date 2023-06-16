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
        if vm.user != nil {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    statsCell()
                    tabs()
                }
            }
            .refreshable { vm.refresh() }
            .background(BlurBackground(with: .view_background))
            .scrollContentBackground(.hidden)
        } else {
            ZStack {
                ActivityIndicator()
                BlurBackground(with: .view_background)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
