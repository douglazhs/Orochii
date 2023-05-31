//
//  AniListAccountView+mainStats.swift
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
            self.userInfo()
                .redacted(reason: (vm.user == nil)
                          ? .placeholder
                          : []
                )
        }
    }
    
    /// User banner
    @ViewBuilder
    func banner() -> some View {
        AsyncImage(
            url: URL(string: vm.user?.bannerImage ?? ""),
            transaction: .init(animation: .easeIn(duration: 0.35))
        ) { image in
            if let image = image.image {
                image
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .blendMode(.overlay)
            } else {
                BlurBackground(with: .view_background)
            }
        }
        .frame(
            maxHeight: CGSize.standardImageCell.width * 2
        )
        .clipped()
    }
    
    /// User avatar
    @ViewBuilder
    func avatar() -> some View {
        AsyncImage(
            url: URL(string: vm.user?.avatar?.large ?? ""),
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
            width: CGSize.standardImageCell.width,
            height: CGSize.standardImageCell.width
        )
    }
    
    /// User information
    @ViewBuilder
    func userInfo() -> some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack(alignment: .top) {
                self.avatar()
                if Constants.device == .phone { Spacer() }
                self.stats()
            }
        }
        .padding()
    }
    
    /// Main stats
    @ViewBuilder
    func stats() -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10.0) {
                self.item(
                    title: "TOTAL MANGAS",
                    value: "\(vm.user?.statistics?.manga?.count ?? 0)"
                )
                self.item(
                    title: "VOLUMES READ",
                    value: "\(vm.user?.statistics?.manga?.volumesRead ?? 0)"
                )
            }.padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10.0) {
                self.item(
                    title: "CHAPTERS READ",
                    value: "\(vm.user?.statistics?.manga?.chaptersRead ?? 0)"
                )
                self.item(
                    title: "MEAN SCORE",
                    value: String(
                        format: "%.1f",
                        (vm.user?.statistics?.manga?.meanScore ?? 0) / 10
                    )
                )
            }
        }
    }
    
    /// User bio
    @ViewBuilder
    func bio() -> some View {
        self.item(
            title: "BIO",
            value: vm.user?.about?
                .components(separatedBy: "\n")
                .first?
                .replacingOccurrences(of: "`", with: "")
            ?? "None"
        )
    }
    
    /// Stat item
    @ViewBuilder
    func item(title: String, value: String) -> some View{
        VStack(alignment: .leading, spacing: 5.0) {
            Text(title)
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
                .unredacted()
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}
