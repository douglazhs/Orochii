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
    case score, chapter, volume
    
    var description: String {
        switch self {
        case .score:   return "Score"
        case .chapter: return "Ch."
        case .volume:  return "Vol."
        }
    }
}

class ALTrackerViewModel: ObservableObject {
    private var token: String = ""
    @Published var alApi = AniList()
    @Published var currentPicker: ALPicker = .chapter
    @Published var status: ALStatus = .wantTo
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var showAlert: Bool = false
    @Published var showPickers: Bool = false
    @Published var chapter: Double = 0
    @Published var score: Double = 0
    @Published var volume: Double = 0
    @Published var mDexManga: Manga
    @Published var mangas: [Media]?
    @Published var manga: Media?
    @Published var text: String
    
    init(_ manga: Manga) {
        mDexManga = manga
        text = manga.attributes?.title?.en ?? ""
        checkALToken()
        searchManga()
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
        Task { @MainActor in
            do {
                mangas = try await alApi.search(
                    manga: text,
                    token: token
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Verify if the manga is already tracking
    func tracking() -> Bool {
        return false
    }
}
