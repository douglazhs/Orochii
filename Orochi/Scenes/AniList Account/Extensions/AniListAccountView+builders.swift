//
//  AniListAccountView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI

// AniListAccountView+builders
extension AniListAccountView {
    /// View content
    @ViewBuilder
    func content() -> some View {
        ZStack {
            self.banner()
            self.userInfo().padding(.vertical, 5.0)
        }.redacted(reason: (user == nil) ? .placeholder : [])
    }
    
    /// User banner
    @ViewBuilder
    func banner() -> some View {
        ZStack {
            AsyncImage(
                url: URL(string: user?.bannerImage ?? ""),
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
                maxWidth: UIScreen.width,
                maxHeight: UIScreen.height * 0.275
            )
        }
    }
    
    /// User information
    @ViewBuilder
    func userInfo() -> some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack {
                Spacer()
                self.followArea()
            }
            HStack(alignment: .top) {
                self.avatar()
                Spacer()
                self.stats()
            }
            self.bio()
        }
        .padding()
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
                    .cornerRadius(12.0)
            } else { ActivityIndicator() }
        }
        .frame(width: 85.0, height: 85.0)
    }
    
    /// Account stats
    @ViewBuilder
    func stats() -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10.0) {
                self.item(
                    title: "TOTAL MANGAS",
                    value: "\(user?.statistics?.manga.count ?? 0)"
                )
                self.item(
                    title: "VOLUMES READ",
                    value: "\(user?.statistics?.manga.volumesRead ?? 0)"
                )
            }.padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10.0) {
                self.item(
                    title: "CHAPTERS READ",
                    value: "\(user?.statistics?.manga.chaptersRead ?? 0)"
                )
                self.item(
                    title: "OTHER READ",
                    value: "\(user?.statistics?.manga.chaptersRead ?? 0)"
                )
            }
        }
    }
    
    // User bio
    @ViewBuilder
    func bio() -> some View {
        self.item(
            title: "BIO",
            value: user?.about?
                .components(separatedBy: "\n")
                .first?
                .replacingOccurrences(of: "`", with: "")
            ?? "None"
        )
    }
    
    /// Following and followers area
    @ViewBuilder
    func followArea() -> some View {
        HStack(alignment: .center, spacing: 10.0) {
            peopleButton(
                label: "\(vm.following?.count ?? 0)",
                image: "person.line.dotted.person.fill"
            )
            Divider().frame(maxHeight: 17.5)
            peopleButton(
                label: "\(vm.followers?.count ?? 0)",
                image: "person.fill"
            )
        }.padding(.bottom, 20.0)
    }
    
    /// Follower and following button sample
    @ViewBuilder
    func peopleButton(label: String, image: String) -> some View {
        Button { } label: {
            Label {
                if vm.isLoading {
                    ActivityIndicator()
                } else {
                    Text(label)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            } icon: {
                Image(systemName: image)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
            .foregroundColor(.white)
            .fontWeight(.heavy)
        }
        .buttonStyle(.borderless)
        .font(.caption2)
        .unredacted()
    }
    
    /// Stat item
    @ViewBuilder
    func item(title: String, value: String) -> some View{
        VStack(alignment: .leading, spacing: 5.0) {
            Text(title)
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}
