//
//  SocialCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI

extension SocialCell {
    @ViewBuilder
    func content() -> some View {
        HStack(alignment: .top, spacing: 10) {
            self.avatar()
            self.info()
            Spacer()
        }
        .overlay(alignment: .trailing) {
            socialButton()
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
                  ? "person.fill.xmark"
                  : "person.fill.questionmark"
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
        AsyncImage(
            url: URL(string: user?.avatar?.large ?? ""),
            transaction: .init(animation: .easeIn(duration: 0.35))
        ) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(4.5)
            } else { ActivityIndicator() }
        }
        .frame(
            width: CGSize.standardImageCell.width * 0.65,
            height: CGSize.standardImageCell.width * 0.65
        )
    }
    
    /// User information
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(user?.name ?? "")
                .font(.caption)
                .fontWeight(.semibold)
            Text("\(user?.statistics?.manga?.count ?? 0) MANGAS")
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}
