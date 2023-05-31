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
    @Published var user: User?
    @Published var handledUser: User?
    @Published var followers: [User]? = nil
    @Published var following: [User]? = nil
    @Published var isLoading: Bool = false
    @Published var selection: ProfileTabs = .general
    @Published var startYearsStat: [UserStartYearStatistic] = []
    @Published var genresStat: [UserGenreStatistic] = []
    var token: String = ""
    
    init(user: User?) {
        self.user = user
        self.loadToken()
    }
    
    /// Load Bearer token from keychain
    func loadToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let token =  String(
            data: tokenData,
            encoding: .utf8
        ) {
            self.token = token
        }
    }
    
    /// Get authenticated user followers and following people
    /// - Parameter id: Authenticated user Id
    func getPeople(user id: Int) async {
        Task { @MainActor in
            self.isLoading = true
            defer { self.isLoading = false }
            self.followers = await self.getFollowers(
                of: id,
                token: self.token
            )
            self.following = await self.getFollowing(
                of: id,
                token: self.token
            )
        }
    }
    
    /// Refresh user data from AniList client
    func refresh() async {
        Task { @MainActor in
            self.user = await getUser(token: self.token)
            guard let user else { return }
            await getPeople(user: user.id)
            self.unwrapStats()
        }
    }
    
    /// Toggle user follow
    func socialHandler() async {
        guard let user = self.handledUser else { return }
        await self.toggleFollow(
            of: user.id,
            token: self.token
        )
        await self.refresh()
        Task { @MainActor in self.handledUser = nil }
    }
    
    /// Unwrap user stats
    func unwrapStats() {
        guard let user = self.user,
              let stats = user.statistics,
              let manga = stats.manga,
              let startYears = manga.startYears,
              let genres = manga.genres
        else { return }
        self.startYearsStat = startYears
        self.genresStat = genres
    }
}
