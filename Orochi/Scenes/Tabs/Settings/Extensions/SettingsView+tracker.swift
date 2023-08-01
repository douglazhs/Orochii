//
//  SettingsView+tracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI

extension SettingsView {
    /// AniList tracker information cell
    @ViewBuilder
    func trackerCell() -> some View {
        if vm.logged {
            loggedInfo()
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
            if vm.user != nil {
                HStack(alignment: .top) {
                    // USER AVATAR
                    profileAvatar()
                    // USER STATS AND INFORMATION
                    userInfo()
                    Spacer()
                }.frame(alignment: .top)
            } else { ActivityIndicator() }
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
        if let url = URL(string: vm.user?.avatar?.large ?? "") {
            MangaStandardImage(
                url: url,
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.width
                )
            )
        }
    }
    
    /// Custom navigation link to user profile screen
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
