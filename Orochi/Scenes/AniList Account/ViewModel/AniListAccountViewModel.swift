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
    @Published var user: User? = nil
    @Published var handledUser: User? = nil
    @Published var followers: [User]? = nil
    @Published var following: [User]? = nil
    @Published var isLoading: Bool = false
    @Published var selection: ProfileTabs = .general
    @Published var startYearsStat: [UserStartYearStatistic] = []
    @Published var genresStat: [UserGenreStatistic] = []
    @Published var activities: [ActivityUnion]? = nil
    private var token: String = ""
    
    init(user: User?) {
        self.user = user
        self.loadToken()
        self.fetch(isRefresh: false)
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
    
    /// Refresh user data from AniList client
    func fetch(isRefresh: Bool) {
        Task { @MainActor in
            guard let user else { return }
            self.isLoading = true
            defer { self.isLoading = false }
            self.getPeople(user: user.id)
            self.activities(user: user.id)
            self.unwrapStats()
        }
    }
    
    /// Get authenticated user followers and following people
    /// - Parameter id: Authenticated user Id
    func getPeople(user id: Int) {
        Task { @MainActor in
            do {
                self.followers = try await self.getFollowers(
                    of: id,
                    token: self.token
                )
                self.following = try await self.getFollowing(
                    of: id,
                    token: self.token
                )
            } catch {
                dump("\(error)")
            }
        }
    }
    
    /// Get current user activities
    /// - Parameter user: Current user
    func activities(user: Int) {
        Task { @MainActor in
            do {
                self.activities = try await getActivities(
                    of: user,
                    token: self.token
                )
            } catch {
                dump("\(error)")
            }
        }
    }
    
    /// Toggle user follow
    func socialHandler() async {
        guard let user = self.handledUser else { return }
        do {
            try await self.toggleFollow(
                of: user.id,
                token: self.token
            )
        } catch {
            dump("\(error)")
        }
        Task { @MainActor in
            self.getPeople(user: user.id)
            self.handledUser = nil
        }
    }
    
    /// Unwrap user stats
    func unwrapStats() {
        guard let user = self.user,
              let stats = user.statistics,
              let manga = stats.manga,
              let startYears = manga.startYears,
              let genres = manga.genres
        else { return }
        let sortedStartYears = startYears.sorted {
            $0.startYear ?? 0 < $1.startYear ?? 0
        }
        let mappedGenres = genres.filter {
            $0.chaptersRead != 0
        }
        self.startYearsStat = sortedStartYears
        self.genresStat = mappedGenres
    }
}
