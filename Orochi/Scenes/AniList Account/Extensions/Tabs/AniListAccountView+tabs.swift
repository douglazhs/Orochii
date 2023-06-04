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
                .padding(.horizontal)
            switch vm.selection {
            case .general:   self.general().padding(.top, 10.0)
            case .stats:     self.chartStats().padding(.top, 10.0)
            case .following: self.followTab(users: vm.following).padding(.top, 10)
            case .followers: self.followTab(users: vm.followers).padding(.top, 10)
            }
        }
    }
        
    /// General information
    @ViewBuilder
    func general() -> some View {
        VStack(alignment: .leading, spacing: 15.0) {
            self.bio()
            self.userActivities()
        }
        .padding(.horizontal)
    }
    
    /// User charts
    @ViewBuilder
    func chartStats() -> some View {
        VStack(alignment: .leading, spacing: 15.0) {
            self.genresChart()
            self.readChaptersYearChart()
        }
        .padding(.horizontal)
    }
    
    /// Following/Followers tab
    /// - Parameter users: Following/Followers
    @ViewBuilder
    func followTab(users: [User]?) -> some View {
        if let users = users {
            LazyVStack(alignment: .leading, spacing: 10.0) {
                ForEach(users) { user in
                    NavigationLink {
                        AniListAccountView(user: user)
                    } label: {
                        SocialCell(user: user) { action, tappedUser in
                            vm.handledUser = tappedUser
                            switch action {
                            case .follow: Task { await vm.socialHandler() }
                            case .unfollow: self.showAlert = true
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .alert(
                        String.Common.attention,
                        isPresented: $showAlert
                    ) {
                        Button(String.Common.cancel, role: .cancel) { }
                        Button("Unfollow", role: .destructive) {
                            Task { await vm.socialHandler() }
                        }
                    } message: {
                        Text("Are you sure you want to remove this user of your following list?")
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
