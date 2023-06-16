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
    @Published var alertInfo: AlertInfo = .init()
    @Published var showAlert: Bool = false
    @Published var showDialog: Bool = false
    private var requestError: Error? = nil
    private var token: String = ""
    
    init(_ user: Int) {
        loadToken()
        fetch(user)
    }
    
    /// Load Bearer token from keychain
    func loadToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let resultToken =  String(
            data: tokenData,
            encoding: .utf8
        ) { token = resultToken }
    }
    
    /// Refresh user data from AniList client
    func fetch(_ id: Int) {
        defer { isLoading = false }
        isLoading = true
        getUser(id: id)
        getPeople(user: id)
        activities(user: id)
    }
    
    /// Refresh user page
    func refresh() {
        guard let user else { return }
        getPeople(user: user.id)
        activities(user: user.id)
        unwrapStats()
    }
    
    /// Get user by Id
    /// - Parameter id: User Id
    func getUser(id: Int) {
        Task { @MainActor in
            do {
                user = try await getUser(
                    by: id,
                    token: token
                )
            } catch {
                isLoading = false
                requestError = error
                showAlert(error)
            }
        }
    }
    
    /// Get authenticated user followers and following people
    /// - Parameter id: Authenticated user Id
    func getPeople(user id: Int) {
        Task { @MainActor in
            do {
                followers = try await getFollowers(
                    of: id,
                    token: token
                )
                following = try await getFollowing(
                    of: id,
                    token: token
                )
            } catch {
                isLoading = false
                requestError = error
                showAlert(error)
            }
        }
    }
    
    /// Get current user activities
    /// - Parameter user: Current user
    func activities(user: Int) {
        Task { @MainActor in
            do {
                activities = try await getActivities(
                    of: user,
                    token: token
                )
            } catch {
                isLoading = false
                requestError = error
                showAlert(error)
            }
        }
    }
    
    /// Toggle user follow
    func socialHandler() async {
        guard let user = handledUser else { return }
        do {
            try await toggleFollow(
                of: user.id,
                token: token
            )
        } catch {
            requestError = error
            showAlert(error)
        }
        Task {  @MainActor in
            guard let user = self.user else { return }
            getPeople(user: user.id)
            handledUser = nil
        }
    }
    
    /// Unwrap user stats
    func unwrapStats() {
        guard let user,
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
        }.sorted(by: { $0.chaptersRead ?? 0 < $1.chaptersRead ?? 0 })
        startYearsStat = sortedStartYears
        genresStat = mappedGenres
    }
    
    /// Show alert
    /// - Parameters:
    ///   - error: Throw error
    func showAlert(_ error: Error) {
        showAlert = true
        let failureReason = (error as? HTTPStatusCode)?.failureReason
        alertInfo = .init(
            title: failureReason ?? String.Common.error,
            message: error.localizedDescription
        )
    }
}
