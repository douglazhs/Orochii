//
//  MangaViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import MangaDex

class MangaViewModel: ObservableObject {
    @Published var api: MangaDexAPIProtocol = MangaDexAPI()
    @Published var manga: Manga
    @Published var chapters: [Chapter]?
    @Published var selectedChapter: Chapter?
    @Published var loading: Bool = false
    @Published var descLang: Language = .enUS
    @Published var languagePreferences: [Language] = []
    @Published var mangaOnLib: Bool = false
    @Published var selectAll: Bool = false
    @Published var occurredAct: Bool = false
    @Published var selection = Set<UUID>()
    @Published var isEditingMode: Bool = false
    @Published var showBottomBar: Bool = false
    @Published var downloaded: Bool = false
    @Published var chaptersOrder: OrderFilter = .ascending
    @Published var queryFilter: String = ""
    @Published var search: Bool = false
    @Published var actionMessage: String = ""
    @Published var truncation: Text.TruncationMode? = .tail
    
    init(manga: Manga) {
        self.manga = manga
        loadDefaults()
        chaptersFeed()
    }
    
    /// Load user defaults
    private func loadDefaults() {
        downloaded = Defaults.standard.getBool(of: DefaultsKeys.Chapters.downloaded.rawValue)
        chaptersOrder = OrderFilter(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.Chapters.order.rawValue)
        ) ?? .ascending
        if let langs = Defaults.standard.getObj(of: DefaultsKeys.SrcPreferences.languages.rawValue) as? [Int] {
            languagePreferences = langs.map { Language(rawValue: $0) ?? .enUS }
        }
    }
    
    /// Fetch manga chapters
    func chaptersFeed() {
        loading = true
        api.getMangaFeed(
            id: manga.id,
            params: [
                "translatedLanguage[]" : languagePreferences.compactMap { $0.apiId },
                "limit" : 500,
                "order[chapter]" : "desc"
            ]
        ) { result in
            switch result {
            case .success(let array):
                Task { @MainActor in
                    self.chapters = array.data
                }
                self.loading = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Manga description according with the selected language
    /// - Returns: Description in selected language
    func switchDescLang() -> AttributedString {
        do {
            switch descLang {
            case .ptBr:
                return try AttributedString(
                    markdown: manga.attributes?.description?.ptBr ?? "No description.",
                    options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
                )
            case .enUS:
                return try AttributedString(
                    markdown: manga.attributes?.description?.en ?? "No description.",
                    options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
                )
            }
        } catch {
            switch descLang {
            case .ptBr: return AttributedString(NSAttributedString(string: manga.attributes?.description?.ptBr ?? "No description."))
            case .enUS: return AttributedString(NSAttributedString(string: manga.attributes?.description?.en ?? "No description."))
            }
        }
    }
    
    /// Get value of a key
    /// - Parameters:
    ///   - key: Object key
    ///   - manga: Current manga
    /// - Returns: Value associated to the key
    func getValue(_ key: String) -> String {
        guard let relationships = manga.relationships,
              let entity = relationships.first(where: { $0.type == key })
        else { return "" }
        return entity.attributes?.name ?? ""
    }
    
    /// Get value of a key
    /// - Parameters:
    ///   - key: Object key
    ///   - chapter: Current chapter
    /// - Returns: Value associated to the key
    func getValue(_ key: String, from chapter: Chapter) -> String {
        guard let relationships = chapter.relationships,
              let entity = relationships.first(where: { $0.type == key })
        else { return "" }
        return entity.attributes?.name ?? ""
    }
    
    /// Convert the manga genres in one string
    /// - Parameter manga: Current manga
    /// - Returns: Converted string with all genres
    func getGenres() -> String {
        guard let tags = manga.attributes?.tags else { return "" }
        let genres = tags.filter { $0.attributes?.group ?? "" == "theme" || $0.attributes?.group ?? "" == "genre" }
        return genres.compactMap { $0.attributes?.name?.en ?? "" }.joined(separator: ", ")
    }
    
    /// Get cover art file name
    /// - Parameter manga: Current manga
    /// - Returns: Cover art file name
    func fileName() -> String {
        guard let cover = manga.relationships?.first(where: { $0.type == "cover_art" }),
              let fileName = cover.attributes?.fileName else {
            return ""
        }
        return fileName
    }
    
    /// Start action when a button is pressed
    /// - Parameter action: Actual action
    func startAction(for action: MangaActions) {
        switch action {
        case .aniList:            anilistHandler()
        case .history(let clear): historyHandler(clear)
        case .lib:                libraryHandler()
        }
        buildPopUp(for: action)
    }
    
    /// Add manga to library
    private func addToLib() throws {
        withAnimation(.linear(duration: 0.175)) { occurredAct = true }
        mangaOnLib = true
        Haptics.shared.notify(.success)
    }
    
    /// Remove manga from library
    private func removeFromLib() throws {
        withAnimation(.linear(duration: 0.175)) { occurredAct = true }
        mangaOnLib = false
        Haptics.shared.notify(.error)
    }
    
    /// Handle manga actions
    private func libraryHandler() {
        do {
            mangaOnLib ? try removeFromLib() :  try addToLib()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// History actions
    private func historyHandler(_ clear: Bool) {
        if clear { clearHistory() }
    }
    
    /// Clear manga history
    private func clearHistory() {
        withAnimation(.linear(duration: 0.175)) { occurredAct = true }
        Haptics.shared.notify(.error)
    }
    
    /// Anilist update action
    private func anilistHandler() { }
    
    /// Build pop up message
    private func buildPopUp(for action: MangaActions) {
        switch action {
        case .lib:
            actionMessage = mangaOnLib ? "Successfully Added" : "Successfully Removed"
        case .aniList:
            actionMessage = "Successfully Updated"
        case .history:
            actionMessage = "Successfully Cleared"
        }
    }
}
