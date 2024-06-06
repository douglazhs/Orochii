//
//  MangaViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import MangaDex
import Combine

struct CoverFilter: Equatable {
    var locales: [String] = [String]()
    var volOrder: OrderFilter = .desc
    
    static func == (lhs: CoverFilter, rhs: CoverFilter) -> Bool {
        return lhs.locales == rhs.locales && lhs.volOrder == rhs.volOrder
    }
}

// MangViewModel+MangaHelpers
extension MangaViewModel: MangaHelpers {  }

final class MangaViewModel: ObservableObject {
    /// MangaDex Api service
    let api: MangaDexAPIProtocol = MangaDexAPI()
    /// Current manga
    @Published var manga: Manga
    /// Selected chapter to reads
    @Published var selectedChapter: Chapter?
    // MARK: - User Defaults
    @Published var coverQuality: CoverQuality = .original
    // MARK: - Arrays
    @Published var chapters: [Chapter] = [Chapter]()
    @Published var filtered: [Chapter] = [Chapter]()
    @Published var covers: [Cover] = [Cover]()
    @Published var filteredCovers: [Cover] = [Cover]()
    @Published var locales: [String] = [String]()
    @Published var languagePreferences: [Language] = [Language]()
    @Published var tags: [MangaTag] = [MangaTag]()
    // MARK: - View states - Booleans & Strings
    @Published var loadingFeed: Bool = false
    @Published var loadingCovers: Bool = false
    @Published var selectAll: Bool = false
    @Published var occurredAct: Bool = false
    @Published var isEditingMode: Bool = false
    @Published var showBottomBar: Bool = false
    @Published var actionMessage: String = ""
    // MARK: - Core Data
    @Published var libStatus: MangaStatus = .none
    @Published var mangaOnLib: Bool = false
    // MARK: - Filtering
    @Published var markAll: Bool = true
    @Published var coverFilter = CoverFilter()
    @Published var oldCoverFilter = CoverFilter()
    @Published var downloaded: Bool = false
    @Published var search: Bool = false
    @Published var filterQuery: String = ""
    @Published var feedOrder: OrderFilter = .asc
    @Published var descLang: String = "en"
    // MARK: - Networking
    @Published var totalOnFeed: Int = 0
    @Published var offset: Int = 0
    
    init(_ manga: Manga) {
        self.manga = manga
        initialBuild()
        print("Created \(manga.attributes?.title?.en ?? "") ViewModel")
    }
    
    deinit {
        print("Deinit \(manga.attributes?.title?.en ?? "") ViewModel")
    }

    /// Make initial view build
    func initialBuild() {
        loadUserDefaults()
        buildTags()
        buildFeed()
    }
    
    /// Load user defaults
    private func loadUserDefaults() {
        downloaded = Defaults.standard.getBool(of: DefaultsKeys.Chapters.downloaded.rawValue)
        feedOrder = OrderFilter(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.Chapters.order.rawValue)
        ) ?? .asc
        if let langs = Defaults.standard.getObj(of: DefaultsKeys.SrcPreferences.languages.rawValue) as? [Int] {
            languagePreferences = langs.map { Language(rawValue: $0) ?? .enUS }
        }
        coverQuality = CoverQuality(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.SrcPreferences.coverQuality.rawValue)
        ) ?? .original
    }
    /// Format carousel containing format and content information
    private func buildTags() {
        if let cr = manga.attributes?.contentRating,
            let formats = getTags(with: "format", of: manga),
            let content = getTags(with: "content", of: manga) {
            tags.append(
                MangaTag(
                    title: cr.capitalized,
                    .contentRating(.init(rawValue: cr) ?? .safe)
                )
            )
            tags.append(contentsOf: content.map { MangaTag(title: $0, .content) })
            tags.append(contentsOf: formats.map { MangaTag(title: $0, .format) })
        }
    }
    
    /// Load initial feed
    private func buildFeed() {
        withAnimation(.spring()) {
            loadingFeed = true
        }
        fetchFeed()
    }
    
    /// Verify if the user scrolled to the end of the carousel
    /// - Parameter manga: last manga on carousel
    /// - Returns: Boolean
    func hasReachedEnd(of manga: Chapter) -> Bool {
        chapters.last?.id == manga.id
    }
    
    /// Manage chapter selction
    func manageSelection(_ selection: Binding<Set<String?>>) {
        if selectAll {
            chapters.forEach {
                selection.wrappedValue.insert($0.id)
            }
        } else {
            selection.wrappedValue.removeAll()
        }
    }
    
    /// Manga description according with the selected language
    /// - Returns: Description in selected language
    func switchDescLang() -> AttributedString {
        do {
            return try AttributedString(
                markdown: manga.attributes?.description?[descLang] ?? "No description.",
                options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
        } catch {
            return "No description."
        }
    }
    
    /// Convert alt titles in only on dictionary
    func convertedAltTitles() -> [String: String] {
        var converted: [String: String] = [:]
        manga.attributes?.altTitles?.forEach { dict in
            for (key, title) in dict {
                converted[key] = title
            }
        }
        return converted
    }
    
    /// Start action when a button is pressed
    /// - Parameter action: Actual action
    func startAction(for action: MangaAction) {
        switch action {
        case .aniList: break
        case .lib(let subAction):
            withAnimation(.linear(duration: 0.175)) {
                occurredAct = true
            }
            switch subAction {
            case .changeFolder:
                mangaOnLib = true
            case .remove:
                mangaOnLib = false
                libStatus = .none
            }
        }
        buildPopUp(for: action)
    }
    
    /// Build pop up message
    /// - Parameter action: occurred action
    private func buildPopUp(for action: MangaAction) {
        switch action {
        case .lib(let subAction):
            switch subAction {
            case .changeFolder:
                Haptics.shared.play(.light)
                actionMessage = "\(subAction.description.capitalized) to \(libStatus.description)"
            case .remove:
                Haptics.shared.play(.heavy)
                actionMessage = subAction.description
            }
        case .aniList:
            actionMessage = "Successfully Updated"
        }
    }
}

// MARK: MangaViewModel+Filter --------------------------------------------------------------------------------------

extension MangaViewModel {
    /// Order chapters using user preference
    func orderFeed(by option: OrderFilter) {
        filtered.reverse()
        Defaults.standard.saveInt(
            option.rawValue,
            key: DefaultsKeys.Chapters.order.rawValue
        )
    }
    
    /// Filter manga chapters
    func filterFeed() {
        if !filterQuery.isEmpty {
            filtered = chapters.filter {
                filterQuery == $0.attributes?.chapter ||
                $0.attributes?.title?.localizedCaseInsensitiveContains(filterQuery) ?? false
            }
        } else { filtered = chapters }
    }
    
    /// Cancel filter
    func cancelFeedFilter() {
        search = false
        filterQuery = ""
        filtered = chapters
    }
    
    /// Filter covers by user filter preferences
    func filterCovers() {
        if coverFilter != oldCoverFilter {
            withTransaction(.init(animation: .snappy(duration: 0.5))) {
                filteredCovers = covers.filter { coverFilter.locales.contains($0.attributes.locale ?? "") }
                
                switch coverFilter.volOrder {
                case .asc:
                    covers.sort(by: { $0.attributes.volume < $1.attributes.volume })
                    filteredCovers.sort(by: { $0.attributes.volume < $1.attributes.volume })
                case .desc:
                    covers.sort(by: { $0.attributes.volume > $1.attributes.volume })
                    filteredCovers.sort(by: { $0.attributes.volume > $1.attributes.volume })
                }
            }
        }
    }
    
    /// Mark or remove all locale selection
    func toggleLocaleSelection() {
        withTransaction(.init(animation: .smooth(duration: 0.25))) {
            markAll.toggle()
            if markAll {
                coverFilter.locales = locales
            } else { coverFilter.locales.removeAll() }
        }
    }
}

// MARK: MangaViewModel+Network -------------------------------------------------------------------------------------

extension MangaViewModel {
    /// Fetch manga chapters
    private func fetchFeed() {
        Task { @MainActor in
            api.getMangaFeed(
                id: manga.id,
                params: [
                    "translatedLanguage[]": languagePreferences.compactMap { $0.apiId },
                    "limit": 500,
                    "offset": offset,
                    "order[chapter]": feedOrder.key
                ]
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    if let chapters = response.data,
                        let total = response.total {
                        withAnimation(.spring()) {
                            self?.chapters.append(contentsOf: chapters)
                            self?.totalOnFeed = total
                            self?.fetchMore()
                        }
                    }
                case .failure(_):
                    withAnimation(.easeInOut(duration: 0.225)) {
                        self?.loadingFeed = false
                    }
                }
            }
        }
    }
    
    /// Get manga cover list
    func getCovers() {
        guard covers.isEmpty else { return }
        loadingCovers = true
        Task { @MainActor in
            api.getCoverList(manga.id) { [weak self] in
                switch $0 {
                case .success(let response):
                    self?.locales = response.data
                        .removingDuplicates(withSame: \.attributes.locale)
                        .compactMap { $0.attributes.locale }
                    self?.coverFilter.locales = self?.locales ?? []
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withTransaction(.init(animation: .snappy(duration: 0.25))) {
                            self?.loadingCovers = false
                            self?.covers = response.data
                            self?.filteredCovers = response.data
                        }
                    }
                case .failure(let error):
                    withTransaction(.init(animation: .snappy(duration: 0.25))) {
                        self?.loadingCovers = false
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Fetch more chapters when reached the end of scroll
    func fetchMore() {
        if totalOnFeed > 500 && offset <= totalOnFeed {
            offset += 500
            fetchFeed()
            return
        }
        
        withAnimation(.spring()) {
            loadingFeed = false
        }
        // End the fetch of the chapters
        filtered = chapters
    }
    
    /// Refresh manga
    func refresh() {
        Task { @MainActor in
            api.getById(manga.id) { [weak self] result in
                switch result {
                case .success(let manga): self?.manga = manga.data
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
