//
//  ALAccountViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/03/24.
//

import Foundation
import SwiftUI
import AniListService
import Alamofire

final class ALAccountViewModel: ObservableObject {
    enum ViewState {
        case loading, loaded, failed
    }
    
    enum WebView {
        case profile, manga, activity
    }
    
    var user: User
    let api: ALServices = AniList()
    
    @Published var tab: ALTab = .stats
    @Published var favorites: [Media] = [Media]()
    @Published var activities: [ActivityUnion] = [ActivityUnion]()
    @Published var activitiesState: ViewState = .loaded
    @Published var favoritesState: ViewState = .loaded
    @Published var webView: WebView = .profile
    @Published var selectedManga: Media?
    @Published var selectedActivity: Int?
    @Published var errorMessage: String?
    @Published var validURL: URL?
    @Published var feed: Feed = .mine
    @Published var loadedFeed: Bool = false
    @Published var page: Int = 1
    @Published var showAlert: Bool = false
    
    init(user: User) {
        self.user = user
        getMediListEntry()
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
        guard let userFavs = user.favourites,
            let collection = userFavs.manga,
            let mangas = collection.nodes else { return }
        
        favorites = mangas
    }
    
    /// Verify if the user scrolled to the end of the list
    /// - Parameters:
    ///   - activity: Last activity of list
    /// - Returns: Boolean
    func hasReachedEnd(in activity: ActivityUnion) -> Bool {
        activities.last?.id == activity.id
    }
    
    /// Change between feeds
    func changeFeed() {
        loadedFeed = false
        page = 1
        activities.removeAll()
        loadFeed()
    }
    
    /// Get more activities if scroll reached the end
    func paginateFeed() {
        loadedFeed = false
        page += 1
        loadFeed()
    }
    
    /// Get Authemticated User activities
    func loadFeed() {
        guard !loadedFeed else { return }
        // Show activity indicator just in first request. When `page` number is > 1, that's a pagination
        if page == 1 {
            withTransaction(.init(animation: .snappy(duration: 0.5))) {
                self.activitiesState = .loading
            }
        }
        // The request is very fast and you can't see the loading view, so... :)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.getActivities()
        }
    }
    
    /// Get current feed API response
    private func getActivities() {
        errorMessage = nil
        Task { @MainActor in
            do {
                switch feed {
                case .mine:
                    guard let response = try await api.getActivities(
                        of: user.id,
                        token: loadToken(),
                        page: page
                    ) else { return }
                    handle(response)
                case .following:
                    guard let response = try await api.getActivities(
                        token: loadToken(),
                        page: page
                    ) else { return }
                    handle(response)
                }
            } catch {
                showAlert(error)
                activitiesState = .failed
            }
        }
    }
    
    
    /// Handle activity response
    /// - Parameter response: Activity response
    func handle(_ response: [ActivityUnion]) {
        withTransaction(.init(animation: .snappy(duration: 0.5))) {
            activities.append(contentsOf: response)
            loadedFeed = true
            activitiesState = .loaded
        }
    }
    
    /// Refresh current tab
    func refreshTab() {
        switch tab {
        case .stats: break
        case .activity: loadFeed()
        case .favorites: break
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
            completion(.success(validURL))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    /// Unwrap the possible media titles
    /// - Returns: Media unwrapped title
    /// - Parameter manga: Current manga
    func unwrappedTitle(of manga: ShortMedia?) -> String {
        return manga?.title?.english ?? manga?.title?.romaji ?? String.Common.unknown
    }
    
    /// Handle api error
    /// - Parameter error: Catched error
    private func showAlert(_ error: Error) {
        showAlert = true
        guard let afError = error.asAFError else {
            errorMessage = error.localizedDescription
            return
        }
        errorMessage = afError.localizedDescription
    }
}
