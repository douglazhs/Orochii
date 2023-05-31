//
//  AniListAccountView+tabs.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import AniListService

extension AniListAccountView {
    /// Following/Followers tab
    /// - Parameter users: Following/Followers
    @ViewBuilder
    func followTab(users: [User]?) -> some View {
        ForEach(users ?? []) { user in
            SocialCell(user: user) { action, user in
                vm.handledUser = user
                switch action {
                case .follow: Task { await vm.socialHandler() }
                case .unfollow: self.showAlert = true
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
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
    
    /// General information
    @ViewBuilder
    func general() -> some View {
        VStack(alignment: .leading) {
            self.bio()
                .padding(.horizontal)
                .padding(.vertical, 10)
        }
    }
    
    /// User charts
    @ViewBuilder
    func chartStats() -> some View {
        VStack(spacing: 15.0) {
            self.genresChart()
            self.readChaptersYearChart()
        }.padding()
    }
}
