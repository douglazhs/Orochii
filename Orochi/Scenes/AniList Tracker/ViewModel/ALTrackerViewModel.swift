//
//  ALTrackerViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI
import AniListService
import MangaDex

// MangaHelpers+MangaHelpers
extension ALTrackerViewModel: MangaHelpers { }

extension ALTrackerViewModel: ALServices { }

/// AniList button field
enum ALPicker {
    case score, chapter, volume
    
    var description: String {
        switch self {
        case .score:   return "Score"
        case .chapter: return "Ch."
        case .volume:  return "Vol."
        }
    }
}

final class ALTrackerViewModel: ObservableObject {
    /// Manga rankings
    enum Rank {
        case rated, popular
    }
    /// Current authenticated AniList user token
    private var token: String = ""
    // MARK: - AniList stuffs
    @Published var alManga: Media?
    @Published var mangas: [Media]?
    @Published var status: MangaStatus = .planning
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var chapter: Double? = 0
    @Published var volume: Double? = 0
    @Published var score: Double? = 0
    @Published var alUrl: URL?
    // MARK: - View states
    @Published var currentPicker: ALPicker = .chapter
    @Published var showAlert: Bool = false
    @Published var loadingById: Bool = false
    @Published var loadingByText: Bool = false
    @Published var availableInAL: Bool = false
    @Published var trackingLocally: Bool = false
    // - MARK: - MangaDex stuffs
    @Published var mDexManga: Manga
    // - MARK: Search query
    @Published var text: String = ""
    
    init(_ manga: Manga) {
        mDexManga = manga
        checkALToken()
        checkALId()
    }
    
    /// Check if the user is logged on AniList account
    private func checkALToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let userToken =  String(data: tokenData, encoding: .utf8) {
            token = userToken
        }
    }
    
    /// Search for manga
    func searchManga() {
        withAnimation(.easeIn) { loadingByText = true }
        Task { @MainActor in
            do {
                mangas = try await search(
                    manga: text,
                    token: token
                )
                withAnimation(.easeIn) { loadingByText = false }
            } catch {
                withAnimation(.easeIn) { loadingByText = false }
                print(error.localizedDescription)
            }
        }
    }
    
    /// Clear actual search
    func clearSearch() {
        text = ""
        mangas = nil
        alManga = nil
    }
    
    /// Get manga ranks
    /// - Parameter type: Rank type
    /// - Returns: Rank integer
    func getRank(_ type: Rank) -> Int? {
        switch type {
        case .popular :
            return alManga?.rankings?.first(where: { ($0.type.unwrapped) == "POPULAR" && $0.allTime })?.rank
        case .rated:
            return alManga?.rankings?.first(where: { ($0.type.unwrapped) == "RATED" && $0.allTime })?.rank
        }
    }
    
    /// Fill  manga info
    func fillInfo() {
        // Started date
        if let year = alManga?.mediaListEntry?.startedAt?.year,
           let month = alManga?.mediaListEntry?.startedAt?.month,
           let day = alManga?.mediaListEntry?.startedAt?.day {
            startDate = Date.convert("\(day)-\(month)-\(year)", format: "dd-MM-YYYY")
        } else { startDate = .now }
        
        // Ended date
        if let year = alManga?.mediaListEntry?.completedAt?.year,
           let month = alManga?.mediaListEntry?.completedAt?.month,
           let day = alManga?.mediaListEntry?.completedAt?.day {
            endDate = Date.convert("\(day)-\(month)-\(year)", format: "dd-MM-YYYY")
        } else { endDate = .now }
        
        //Chapter
        chapter = Double(alManga?.mediaListEntry?.progress ?? 0)
        // Volume
        volume = Double(alManga?.mediaListEntry?.progressVolumes ?? 0)
        // Score
        score = Double(alManga?.mediaListEntry?.score ?? 0)
        //Status
        status = MangaStatus(rawValue: alManga?.mediaListEntry?.status ?? "") ?? .planning
    }
    
    /// Get manga on AniList
    private func checkALId() {
        if let anilistId = mDexManga.attributes?.links?.al,
           let integerId = Int(anilistId) {
            withAnimation(.spring()) { loadingById = true }
            Task { @MainActor in
                do {
                    alManga = try await get(media: integerId, token: token)
                    handleTracking()
                    withAnimation(.spring()) { loadingById = false }
                } catch {
                    withAnimation(.spring()) { loadingById = false }
                    print(error.localizedDescription)
                }
                handleTracking()
            }
        } else { handleTracking() }
    }
    
    /// Verify if the manga is already tracking
    func handleTracking() {
        guard alManga != nil else {
            withAnimation(.spring()) { availableInAL = false }
            // Activate the search
            text = unwrapTitle(of: mDexManga)
            return
        }
        withAnimation(.spring()) { availableInAL = true }
        fillInfo()
    }
}
