//
//  SettingsView+ALSection.swift
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
            self.loggedInfo()
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
        HStack(alignment: .top) {
            // USER AVATAR
            self.profileNavigation().unredacted()
            // USER STATS AND INFORMATION
            self.userInfo()
            Spacer()
        }
    }
    
    /// User Avatar
    @ViewBuilder
    func avatar() -> some View {
        if vm.user != nil || vm.isLoading {
            if let url = URL(string: vm.user?.avatar?.large ?? "") {
                AsyncCacheImage(
                    url: url,
                    placeholder:  { ActivityIndicator() }
                ) { image in
                    Image(uiImage: image)
                        .resizable()
                }
            }
        }
    }
    
    /// Custom navigation link to user profile screen
    @ViewBuilder
    func profileNavigation() -> some View {
        ZStack {
            NavigationLink { AniListAccountView(user: vm.user) } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            self.avatar()
                .cornerRadius(4.5)
                .frame(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.width
                )
                .scaledToFill()
                .clipped()
        }
    }
    
    /// User stats
    @ViewBuilder
    func userInfo() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // USERNAME
            Text(vm.user?.name ?? "Unable to load :(")
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
            ? (showDialog = true)
            : vm.logInAL(showErrorDialog: $showErrorDialog)
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
