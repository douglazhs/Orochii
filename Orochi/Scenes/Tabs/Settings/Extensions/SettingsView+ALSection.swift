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
        self.avatar()
            .representableSheet(
                isPresented: $showALAccount,
                content: {
                    AniListAccountView(user: vm.user)
                }, detents: []
            )
    }
    
    /// User Avatar
    @ViewBuilder
    func avatar() -> some View {
        HStack(alignment: .top) {
            // USER AVATAR
            if vm.user != nil || vm.isLoading {
                AsyncImage(
                    url: URL(string: vm.user?.avatar?.large ?? ""),
                    transaction: .init(animation: .linear(duration: 0.25))
                ) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(5.5)
                            .onTapGesture {
                                showALAccount = true
                            }
                    } else { ActivityIndicator() }
                }
                .frame(
                    maxWidth: CGSize.standardImageCell.width,
                    maxHeight: CGSize.standardImageCell.width
                )
            }
            // USER STATS AND INFORMATION
            self.userStats()
            Spacer()
        }
    }
    
    /// User stats
    @ViewBuilder
    func userStats() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // USERNAME
            Text(vm.user?.name ?? "Unable to load :(")
                .font(.subheadline)
                .fontWeight(.semibold)
            // MANGAS
            Text("\(vm.user?.statistics?.manga.count ?? 0) MANGAS")
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
