//
//  AniListAccountView+statsCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import struct AniListService.User

extension AniListAccountView {
    /// Stats cell
    @ViewBuilder
    func statsCell() -> some View {
        ZStack {
            self.banner()
                .frame(
                    maxHeight: CGSize.standardImageCell.width * 2
                )
                .clipped()
            self.userInfo()
                .redacted(reason: (vm.user == nil)
                          ? .placeholder
                          : []
                )
        }
    }
    
    /// User information
    @ViewBuilder
    func userInfo() -> some View {
        HStack(alignment: .top) {
            self.avatar()
                .frame(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.width
                )
                .scaledToFill()
                .unredacted()
            Spacer()
            self.stats()
                .frame(maxHeight: CGSize.standardImageCell.width)
        }.padding()
    }
}
