//
//  ALAccountView+userDetails.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 08/03/24.
//

import Foundation
import SwiftUI

extension ALAccountView {
    @ViewBuilder
    func userDetails() -> some View {
        Section {
            HStack(spacing: 15.0) {
                profileAvatar()
                userInfo()
                Spacer()
            }
        }
        .listSectionSeparator(.hidden)
        .listRowInsets(.init(
            top: 0,
            leading: 22,
            bottom: 0,
            trailing: 22
        ))
    }
    
    @ViewBuilder
    func profileAvatar() -> some View {
        avatar()
            .cornerRadius(4.5)
            .frame(
                width: CGSize.standardImageCell.width,
                height: CGSize.standardImageCell.width
            )
            .scaledToFill()
            .clipped()
            .padding(.vertical)
    }
    
    @ViewBuilder
    func avatar() -> some View {
        if let url = URL(string: vm.user.avatar?.large ?? "") {
            MangaStandardImage(
                url: url,
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.width
                )
            )
        }
    }
    
    @ViewBuilder
    func userInfo() -> some View {
        Text(vm.user.name)
            .font(.subheadline)
            .fontWeight(.semibold)
    }
    
    @ViewBuilder
    func banner() ->  some View {
        if let urlString = vm.user.bannerImage,
           let url = URL(string: urlString) {
            DarkOverlay(url: url)
                .frame(height: CGSize.standardImageCell.height)
                .clipped()
                .ignoresSafeArea(.all)
        }
    }
}
