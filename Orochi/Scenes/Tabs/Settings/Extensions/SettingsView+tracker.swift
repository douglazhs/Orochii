//
//  SettingsView+tracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI
import Kingfisher

extension SettingsView {
    /// AniList tracker information cell
    @ViewBuilder
    func trackerCell() -> some View {
        if vm.logged {
            loggedInfo()
                .redacted(reason: vm.isLoading
                          ? .placeholder
                          : []
                )
        } else {
            WebsiteStandardCell(
                title: String.Name.aniList,
                urlString: AppURLs.ALSite.description,
                image: .ani_list_logo
            )
        }
    }
    
    /// Logged user info
    @ViewBuilder
    func loggedInfo() -> some View {
        if vm.requestError == nil {
            HStack(alignment: .top) {
                // USER AVATAR
                profileNavigation()
                // USER STATS AND INFORMATION
                userInfo()
                Spacer()
            }
        } else {
            HStack {
                Text("Unable to load :(")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }
        }
    }
    
    /// User Avatar
    @ViewBuilder
    func avatar() -> some View {
        if !vm.isLoading {
            if let url = URL(string: vm.user?.avatar?.large ?? ""),
               let mediumUrl = URL(string: vm.user?.avatar?.medium ?? "") {
                KFImage.url(url)
                    .placeholder({ ActivityIndicator() })
                    .fromMemoryCacheOrRefresh()
                    .cacheMemoryOnly()
                    .memoryCacheExpiration(.seconds(10))
                    .fade(duration: 0.375)
                    .lowDataModeSource(.network(mediumUrl))
                    .resizable()
            }
        } else { ActivityIndicator() }
    }
    
    /// Custom navigation link to user profile screen
    @ViewBuilder
    func profileNavigation() -> some View {
        ZStack {
            NavigationLink { AniListAccountView(vm.user?.id ?? 0) } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            avatar()
        }
        .cornerRadius(4.5)
        .frame(
            width: CGSize.standardImageCell.width,
            height: CGSize.standardImageCell.width
        )
        .scaledToFill()
        .clipped()
    }
    
    /// User stats
    @ViewBuilder
    func userInfo() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // USERNAME
            Text(vm.user?.name ?? "Unknown")
                .font(.subheadline)
                .fontWeight(.semibold)
            // MANGAS
            Text("\(vm.user?.statistics?.manga?.count ?? 0) MANGAS")
                .font(.caption)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Button that handle the LogIn and LogOut actions
    @ViewBuilder
    func accButtonHandler() -> some View {
        Button(role: vm.logged ? .destructive : .none) {
            vm.logged
            ? (vm.showDialog = true)
            : vm.logInAL()
        } label: {
            Text(vm.logged
                 ? Localized.logOut.uppercased()
                 : Localized.logIn.uppercased()
            )
            .font(.caption)
            .fontWeight(.heavy)
            .foregroundColor(vm.logged ? .red : .accentColor)
        }
        .buttonStyle(.borderedProminent)
        .tint(.white)
    }
}
