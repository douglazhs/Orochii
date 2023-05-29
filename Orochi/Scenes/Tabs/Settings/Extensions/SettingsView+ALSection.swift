//
//  SettingsView+ALSection.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI

extension SettingsView {
    /// AniLis tracker's information cell
    @ViewBuilder
    func trackerCell() -> some View {
        WebsiteStandardCell(
            header: Localized.trackerHeader,
            title: vm.logged ? "\(vm.user?.name ?? "UNABLE TO LOAD")" : String.Name.aniList,
            urlString: vm.logged
                       ? (vm.user?.siteUrl ?? AppURLs.ALSite.description)
                       : AppURLs.ALSite.description,
            image: .ani_list_logo,
            avatarURL: vm.logged ? URL(string: vm.user?.avatar?.large ?? "") : nil,
            customInfo: vm.logged ? "\(vm.user?.statistics?.manga.count ?? 0) MANGAS" : ""
        )
        .redacted(reason: (vm.isLoading || (vm.logged && vm.user == nil)) ? .placeholder : [])
        .overlay(alignment: .topTrailing) {
            Button {
                showALAccount = true
            } label: {
                Image(systemName: "info.circle.fill")
            }
            .disabled(!vm.logged || vm.user == nil)
            .opacity((vm.logged && vm.user != nil) ? 1.0 : 0.35)
            .foregroundColor(.white)
        }
        .representableSheet(
            isPresented: $showALAccount,
            content: {
                AniListAccountView(user: vm.user)
            }, detents: []
        )
    }
    
    /// Button that handle the LogIn and LogOut actions
    @ViewBuilder
    func accButtonHandler() -> some View {
        HStack {
            Button(role: vm.logged ? .destructive : .none) {
                vm.logged
                ? (showDialog = true)
                : vm.logInAL(showErrorDialog: $showErrorDialog)
            } label: {
                Text(vm.logged ? Localized.logOut.uppercased() : Localized.logIn.uppercased())
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(vm.logged ? .red : .accentColor)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            Spacer()
        }
    }
}
