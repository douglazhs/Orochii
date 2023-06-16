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
            banner()
                .frame(
                    width: UIScreen.width,
                    height: CGSize.standardImageCell.width * 2
                )
                .clipped()
            userInfo()
        }
    }
    
    /// User information
    @ViewBuilder
    func userInfo() -> some View {
        HStack(alignment: .top) {
            avatar()
                .frame(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.width
                )
                .scaledToFill()
            Spacer()
            stats()
                .frame(maxHeight: CGSize.standardImageCell.width)
        }.padding()
    }
}
