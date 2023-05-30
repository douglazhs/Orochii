//
//  AniListAccountViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/05/23.
//

import SwiftUI
import AniListService

/// AniList account view model
final class AniListAccountViewModel: ObservableObject, ALServices {
    @Published var followers: [User]? = nil
    @Published var following: [User]? = nil
    @Published var isLoading: Bool = false
    
    /// Get authenticated user followers and following people
    /// - Parameter id: Authenticated user Id
    func getPeople(user id: Int) async {
        Task { @MainActor in
            self.isLoading = true
            defer { self.isLoading = false }
            self.followers = await self.getFollowers(of: id)
            self.following = await self.getFollowing(of: id)
        }
    }
}
