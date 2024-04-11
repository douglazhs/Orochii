//
//  ALAccountViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/03/24.
//

import Foundation
import SwiftUI
import AniListService

enum Feed: Pickable {
    var id: Self { self }
    
    case mine, following
    
    var description: String {
        switch self {
        case .mine: return "Your Feed"
        case .following: return "Following Feed"
        }
    }
}

final class ALAccountViewModel: ObservableObject {
    enum ViewState {
        case loading, loaded
    }
    
    enum WebView {
        case profile, manga, activity
    }
    
    var user: User
    let api: ALServices = AniList()
    
    @Published var favorites: [Media] = [Media]()
    @Published var activities: [ActivityUnion] = [ActivityUnion]()
    @Published var activitiesState: ViewState = .loading
    @Published var favoritesState: ViewState = .loading
    @Published var webView: WebView = .profile
    @Published var selectedManga: Media?
    @Published var selectedActivity: Int?
    @Published var errorMessage: String?
    @Published var validURL: URL?
    @Published var feed: Feed = .mine
    @Published var loadedFeed: Bool = false
    @Published var page: Int = 1
    
    init(user: User) {
        self.user = user
    }
    
    /// Load Bearer token for the current authenticated user
    private func loadToken() -> String? {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let token =  String(data: tokenData, encoding: .utf8) {
            return token
        }
        
        return nil
    }
    
    /// Get Media List Entry for the current Authenticated User
    func getMediListEntry() {
        guard favorites.isEmpty else { return }
        
        guard let userFavs = user.favourites,
            let collection = userFavs.manga,
            let mangas = collection.nodes else { return }
        
        withTransaction(.init(animation: .easeIn)) { favoritesState = .loading }
        
        mangas.forEach { manga in
            Task { @MainActor in
                do {
                    guard let favorite = try await api.get(
                        media: manga.id,
                        token: loadToken()
                    ) else { return }
                    favorites.append(favorite)
                } catch {
                    // TODO: - Threat error
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withTransaction(.init(animation: .easeIn)) { self.favoritesState = .loaded }
        }
    }
    
    /// Verify if the user scrolled to the end of the list
    /// - Parameters:
    ///   - activity: last activity of list
    /// - Returns: Boolean
    func hasReachedEnd(of activity: ActivityUnion) -> Bool {
        activities.last?.id == activity.id
    }
    
    /// Change between feeds
    func changeFeed() {
        loadedFeed = false
        page = 1
        activities.removeAll()
        loadFeed()
    }
    
    /// Get Authemticated User activities
    func loadFeed() {
        guard !loadedFeed else { return }
        defer {
            loadedFeed = true
            if page == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    withTransaction(.init(animation: .easeIn)) {
                        self.activitiesState = .loaded
                    }
                }
            }
        }
        
        if page == 1 {
            withTransaction(.init(animation: .easeIn)) {
                activitiesState = .loading
            }
        }
        getActivities()
    }
    
    /// Get activities based on choosen feed
    private func getActivities() {
        switch feed {
        case .mine:
            Task { @MainActor in
                do {
                    guard let response = try await api.getActivities(
                        of: user.id,
                        token: loadToken(),
                        page: page
                    ) else { return }
                    activities.append(contentsOf: response)
                } catch {
                    // TODO: - Threat error
                    activitiesState = .loaded
                }
            }
        case .following:
            Task { @MainActor in
                do {
                    guard let response = try await api.getActivities(
                        token: loadToken(),
                        page: page
                    ) else { return }
                    activities.append(contentsOf: response)
                } catch {
                    // TODO: - Threat error
                    activitiesState = .loaded
                }
            }
        }
    }
    
    /// Build stauts of user activity
    /// - Parameter activity: User activity
    /// - Returns: Built text
    func buildActivity(_ activity: ActivityUnion) -> AttributedString {
        let user = "**\(activity.user?.name ?? String.Common.unknown)**"
        let status = activity.status?.capitalized ?? ""
        var progress = "\(activity.progress ?? "")"
        if !progress.isEmpty { progress += " of" }
        let title = "**\(unwrappedTitle(of: activity.media))**"
        let phrase = [
            user,
            status,
            progress,
            title
        ]
        .filter { !$0.isEmpty }
        .joined(separator: " ")
        
        do {
            let string = try AttributedString(markdown: phrase)
            return string
        } catch {
            return AttributedString(phrase)
        }
    }
        
    
    /// Build WebView URL for .profile and .manga
    /// - Returns: Built URL
    private func buildWebViewUrl() throws -> URL {
        switch webView {
        case .profile:
            guard let url = URL(
                string: user.siteUrl ?? ""
            ) else { throw URLError.empty }
            return url
        case .manga:
            guard let manga = selectedManga?.id else { throw ObjectError.empty }
            guard let url = URL(
                string: AppURLs.alSite.description + "/manga/\(manga)"
            ) else { throw URLError.empty }
            return url
        case .activity:
            guard let activity = selectedActivity else { throw ObjectError.empty }
            guard let url = URL(
                string: AppURLs.alSite.description + "/activity/\(activity)"
            ) else { throw URLError.empty }
            return url
        }
    }
    
    /// Validate current URL
    /// - Parameter completion: URL validation
    func validateURL(completion: @escaping (Result<URL?, Error>) -> Void) {
        do {
            validURL = try buildWebViewUrl()
            errorMessage = nil
            completion(.success(validURL))
        } catch let error {
            errorMessage = error.localizedDescription
            completion(.failure(error))
        }
    }
    
    /// Unwrap the possible media titles
    /// - Returns: Media unwrapped title
    /// - Parameter manga: Current manga
    func unwrappedTitle(of manga: ShortMedia?) -> String {
        return manga?.title?.english ?? manga?.title?.romaji ?? String.Common.unknown
    }
}
