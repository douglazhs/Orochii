//
//  SocialCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import Kingfisher

extension SocialCell {
    @ViewBuilder
    func content() -> some View {
        HStack(alignment: .top, spacing: 10.0) {
            self.avatar()
                .frame(
                    width: CGSize.standardImageCell.width * 0.65,
                    height: CGSize.standardImageCell.width * 0.65
                )
            self.info()
            Spacer()
        }
        .overlay(alignment: .trailing) {
            if !authenticated { socialButton() }
        }
    }
    
    /// Follow/Unfollow button
    @ViewBuilder
    func socialButton() -> some View {
        Button {
            (user?.isFollowing ?? false)
            ? action?(.unfollow, user)
            : action?(.follow, user)
        } label: {
            Image(systemName: user?.isFollowing ?? false
                  ? "person.crop.circle.fill.badge.minus"
                  : "person.crop.circle.fill.badge.plus"
            )
            .foregroundColor(user?.isFollowing ?? false
                             ? Color(uiColor: .systemRed)
                             : .white
            )
            .font(.subheadline)
        }
    }
    
    /// User avatar
    @ViewBuilder
    func avatar() -> some View {
        if let url = URL(string: user?.avatar?.large ?? ""),
           let mediumUrl = URL(string: user?.avatar?.medium ?? "") {
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .lowDataModeSource(.network(mediumUrl))
                .resizable()
                .clipShape(Circle())
                .scaledToFill()
        }
    }
    
    /// User information
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(authenticated ? "You" : user?.name ?? "")
                .font(.caption)
                .fontWeight(.semibold)
            Text("\(user?.statistics?.manga?.count ?? 0) MANGAS")
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}
