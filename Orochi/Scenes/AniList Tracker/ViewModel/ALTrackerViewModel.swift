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

final class ALTrackerViewModel: ObservableObject {
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
    @Published var chapter: Double = 0
    @Published var volume: Double = 0
    @Published var score: Double = 0
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
    
    init(_ mDexManga: Manga) {
        self.mDexManga = mDexManga
        self.alManga = alManga
        checkALToken()
        checkALId()
    }
    
    /// Check if the user is logged on AniList account
    private func checkALToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let token =  String(data: tokenData, encoding: .utf8) {
            self.token = token
        }
    }
    
    /// TextField formatter
    /// - Returns: Formatter instance
    func textFieldformatter() -> Formatter {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .none
            if let chCount =  alManga?.chapters {
                formatter.maximum = NSNumber(value: chCount)
            } else {
                formatter.maximum = nil
            }
            formatter.maximumSignificantDigits = 4
            formatter.maximumIntegerDigits = 4
            formatter.generatesDecimalNumbers = false
            return formatter
        }()
        return formatter
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
    
    /// Get manga ranks
    /// - Parameter type: Rank type
    /// - Returns: Rank integer
    func getRank(_ type: Rank) -> Int? {
        switch type {
        case .popular :
            return alManga?.rankings?.first(where: { ($0.type ?? "") == "POPULAR" && $0.allTime })?.rank
        case .rated:
            return alManga?.rankings?.first(where: { ($0.type ?? "") == "RATED" && $0.allTime })?.rank
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
