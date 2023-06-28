//
//  AniListAccountView+tabs.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import AniListService

extension AniListAccountView {
    /// Following and followers area
    @ViewBuilder
    func tabs() -> some View {
        VStack(alignment: .leading) {
            EnumPicker("", selection: $vm.selection)
                .pickerStyle(.segmented)
            switch vm.selection {
            case .activity:  userActivities().padding(.top, 10.0)
            case .stats:     chartStats().padding(.top, 10.0)
            case .following: followTab(users: vm.following).padding(.top, 10)
            case .followers: followTab(users: vm.followers).padding(.top, 10)
            }
        }
        .padding(.horizontal)
        .onChange(of: vm.selection) {
            if $0 == .stats { vm.unwrapStats() }
        }
    }
    
    /// User charts
    @ViewBuilder
    func chartStats() -> some View {
        VStack(alignment: .leading, spacing: 15.0) {
            genresChart()
            Divider()
            readChaptersYearChart()
        }
    }
    
    /// Following/Followers tab
    /// - Parameter users: Following/Followers
    @ViewBuilder
    func followTab(users: [User]?) -> some View {
        if let users = users, let last = users.last {
            LazyVStack(alignment: .leading, spacing: 7.5) {
                ForEach(users) { user in
                    NavigationLink {
                        AniListAccountView(user.id)
                    } label: {
                        SocialCell(
                            user: user,
                            authenticated: vm.isCurrent(user.id)
                        ) { action, tappedUser in
                            vm.handledUser = tappedUser
                            switch action {
                            case .follow: Task { await vm.socialHandler() }
                            case .unfollow: vm.showDialog = true
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .confirmationDialog(String.Common.attention, isPresented: $vm.showDialog) {
                        Button(String.Common.cancel, role: .cancel) { }
                        Button("Unfollow", role: .destructive) {
                            Task { await vm.socialHandler() }
                        }
                    } message: { Text("Are you sure you want to remove \(user.name) of your following list?") }
                    if user != last {
                        Divider()
                            .padding(.leading, CGSize.standardImageCell.width * 0.65 + 10.0)
                    }
                }
            }
        } else {
            Text("Nothing here yet :)")
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}
