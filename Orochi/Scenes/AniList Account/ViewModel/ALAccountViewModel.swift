//
//  ALAccountViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/03/24.
//

import Foundation
import SwiftUI
import AniListService

final class ALAccountViewModel: ObservableObject {
    enum ViewState {
        case loading, loaded
    }
    
    enum WebView {
        case profile, manga, activity
    }
    
    var user: User
    let api: ALServices = AniList()
    @Published var favorites: [Media] = []
    @Published var activities: [ActivityUnion] = []
    @Published var activitiesState: ViewState = .loading
    @Published var favoritesState: ViewState = .loading
    @Published var webView: WebView = .profile
    @Published var selectedManga: Media?
    @Published var selectedActivity: Int?
    @Published var errorMessage: String?
    @Published var validURL: URL?
    
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
                guard let favorite = try await api.get(
                    media: manga.id,
                    token: loadToken()
                ) else { return }
                favorites.append(favorite)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withTransaction(.init(animation: .easeIn)) { self.favoritesState = .loaded }
        }
    }
    
    /// Get Authemticated User activities
    func getActivities() {
        guard activities.isEmpty else { return }
        
        withTransaction(.init(animation: .easeIn)) { activitiesState = .loading }
        
        Task { @MainActor in
            guard let response = try await api.getActivities(of: user.id, token: loadToken()) else { return }
            activities = response
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withTransaction(.init(animation: .easeIn)) { self.activitiesState = .loaded }
        }
    }
    
    /// Build text of user activity
    /// - Parameter activity: User activity
    /// - Returns: Built text
    func buildActivity(_ activity: ActivityUnion) -> String {
        let status = activity.status?.capitalized ?? ""
        let progress = activity.progress ?? ""
        
        return (status + " " + progress).uppercased()
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
    func unwrappedTitle() -> String {
        return selectedManga?.title?.english ?? selectedManga?.title?.romaji ?? "-"
    }
}
