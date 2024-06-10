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
                urlString: AppURLs.alSite.description,
                image: .aniListLogo
            )
        }
    }
    
    /// Logged user info
    @ViewBuilder
    func loggedInfo() -> some View {
        if vm.requestError == nil {
            if vm.user != nil {
                HStack(alignment: .center) {
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
            AsyncImageView(
                url: url,
                size: CGSize(
                    width: CGSize.standardImageCell.width * 0.65,
                    height: CGSize.standardImageCell.width * 0.65
                )
            ).clipShape(Circle())
        }
    }
    
    /// Custom navigation link to user profile screen
    @ViewBuilder
    func profileAvatar() -> some View {
        avatar()
            .onTapGesture { showALAccount = true }
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
                .foregroundColor(Color.ORCH.primaryText)
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
            .foregroundColor(vm.logged ? Color.ORCH.attention : Color.ORCH.button)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.ORCH.secondaryBackground)
        .confirmationDialog(String.Common.attention, isPresented: $vm.showDialog) {
            Button(String.Common.cancel, role: .cancel) { }
            Button(String.Adjusts.logOut, role: .destructive) {
                vm.logOutAL()
            }
        } message: {
            Text(String.Anilist.logOutMessage)
        }
    }
}
