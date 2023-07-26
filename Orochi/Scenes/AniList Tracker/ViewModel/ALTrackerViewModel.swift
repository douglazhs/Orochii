//
//  ALTrackerViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI
import AniListService
import MangaDex

/// AniList button field
enum ALPicker {
    case score, chapter
    
    var description: String {
        switch self {
        case .score:   return "Score"
        case .chapter: return "Chapter"
        }
    }
}

class ALTrackerViewModel: ObservableObject, MangaHelpers {
    private var token: String = ""
    @Published var alApi = AniList()
    @Published var currentPicker: ALPicker = .chapter
    @Published var status: ALStatus = .planning
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var showAlert: Bool = false
    @Published var showPickers: Bool = false
    @Published var chapter: Double = 0
    @Published var score: Double = 0
    @Published var volume: Double = 0
    @Published var mDexManga: Manga
    @Published var alManga: Media?
    @Published var mangas: [Media]?
    @Published var text: String = ""
    @Published var isLoading: Bool = false
    @Published var isTracking: Bool = false
    
    init(_ mDexManga: Manga, _ alManga: Media? = nil) {
        self.mDexManga = mDexManga
        self.alManga = alManga
        checkALToken()
        verifyTracking()
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
    
    /// Search for manga
    func searchManga() {
        withAnimation(.easeIn) { isLoading = true }
        Task { @MainActor in
            do {
                mangas = try await alApi.search(
                    manga: text,
                    token: token
                )
                withAnimation(.easeIn) { isLoading = false }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Fill  manga info
    /// - Parameter mediaListEntry: User media list information
    func fillInfo() {
        chapter = Double(alManga?.mediaListEntry?.progress ?? 0)
        score = Double(alManga?.mediaListEntry?.score ?? 0)
        status = ALStatus(rawValue: alManga?.mediaListEntry?.status ?? "") ?? .planning
    }
    
    /// Verify if the manga is already tracking
    func verifyTracking() {
        guard alManga != nil else {
            isTracking = false
            text = unwrapTitle(of: mDexManga)
            return
        }
        withAnimation(.spring()) { isTracking = true }
        fillInfo()
    }
}
