//
//  DiscoverViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI
import MangaDex

// DiscoverViewModel+MangaHelpers
extension DiscoverViewModel: MangaHelpers { }

// DiscoverViewModel+SourcePreferences
extension DiscoverViewModel: SourcePreferences { }

final class DiscoverViewModel: ObservableObject {
    /// MangaDex api object
    let api: MangaDexAPIProtocol = MangaDexAPI()
    // MARK: - Manga filter/fetch
    @Published var mangas: [Manga] = [Manga]()
    @Published var selectedMainFilter: MainFilter = .mostRelevants
    @Published var offset: Int = 0
    // MARK: - Searching stuffs
    @Published var nameQuery: String = ""
    @Published var searchResult: [Manga]?
    @Published var isSearching: Bool = false
    // MARK: - MangaDex request handling
    @Published var nsfw: Bool = false
    @Published var coverQuality: CoverQuality = .original
    @Published var languages: [Language] = [Language]()
    @Published var shouldReload: Bool = false
    @Published var loading: Bool = false
    // MARK: - Search History
    @Published var history: [String] = [String]()
    // MARK: - Error alert
    @Published var showAlert: Bool = false
    var alertInfo: AlertInfo = .init()
    
    init() {
        loadPreferences()
        loadHistory()
        fetchMangas()
    }
    
    /// Load user defaults
    private func loadPreferences() {
        let rawValues = Defaults.standard.getObj(
            of: DefaultsKeys.SrcPreferences.languages.rawValue
        ) as? [Int] ?? []
        languages = rawValues.map { Language(rawValue: $0) ?? .enUS }
        nsfw = Defaults.standard.getBool(
            of: DefaultsKeys.SrcPreferences.nsfw.rawValue
        )
        coverQuality = CoverQuality(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.SrcPreferences.coverQuality.rawValue)
        ) ?? .original
    }
    
    /// Fetch initial mangas
    private func fetchMangas() {
        Task { @MainActor [weak self] in
            withTransaction(.init(animation: .smooth(duration: 0.25))) {
                self?.loading = true
            }
            self?.fetch { mangas in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withTransaction(.init(animation: .smooth(duration: 0.25))) {
                        self?.loading = false
                    }
                    withTransaction(.init(animation: .linear(duration: 0.25))) {
                        self?.mangas = mangas
                    }
                }
            }
        }
    }
    
    /// Fetch selected filter
    func fetchSelectedFilter() {
        offset = 0
        mangas.removeAll()
        fetchMangas()
    }
    
    /// Fetch mangas
    /// - Parameters:
    ///   - offset: Current request offset
    ///   - completion: Manga request result
    private func fetch(completion: @escaping([Manga]) -> Void) {
        api.getRandomManga(
            params: merge(selectedMainFilter.params, into: defaults()),
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let array):
                completion(array.data)
            case .failure(let error):
                self?.loading = false
                self?.showAlert(error)
            }
        }
    }
    
    /// Search manga by name
    func search() {
        var params: [String: Any] = [
            "limit": 30,
            "order[rating]": "desc"
        ]
        params = merge(params, into: defaults())
        if !nameQuery.isEmpty {
            api.getByName(
                nameQuery,
                params: params
            ) { [weak self] result in
                switch result {
                case .success(let array):
                    withTransaction(.init(animation: .easeIn(duration: 0.225))) {
                        self?.searchResult?.removeAll()
                        self?.searchResult = array.data
                    }
                    withTransaction(.init(animation: .easeIn(duration: 0.225))) {
                        self?.isSearching = false
                    }
                case .failure(let error):
                    withTransaction(.init(animation: .easeInOut(duration: 0.225))) {
                        self?.searchResult = nil
                        self?.isSearching = false
                    }
                    self?.showAlert(error)
                }
            }
        }
    }
    
    /// Verify if the user scrolled to the end of the carousel
    /// - Parameters:
    ///   - manga: last manga of carousel
    ///   - index: current carousel index
    /// - Returns: Boolean
    func hasReachedEnd(of manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    /// Fetch more mangas
    func fetchMore() {
        guard offset <= 150 else { return }
        offset += 30
        
        fetch { [weak self] result in
            withTransaction(
                .init(animation: .easeInOut(duration: 0.25))
            ) {
                self?.mangas.append(contentsOf: result)
            }
        }
    }
    
    /// Reload discover content
    func reload() {
        if shouldReload {
            Task { @MainActor in
                fetch { [weak self] in
                    self?.mangas = $0
                }
            }
        }
        withTransaction(
            .init(animation: .easeInOut(duration: 0.25))
        ) {
            shouldReload = false
        }
    }
    
    /// Load Search History
    func loadHistory() {
        history = Defaults
            .standard
            .getArray(
                of: DefaultsKeys.History.search.rawValue
            ) as? [String] ?? []
    }
    
    /// Save query in Search History
    func saveHistory() {
        Defaults.standard.saveArray(
            of: history,
            key: DefaultsKeys.History.search.rawValue
        )
    }
    
    /// Save history on UserDefaults when user submit the search
    func submitSearch() {
        withTransaction(.init(animation: .bouncy(duration: 0.25))) {
            if !history.contains(nameQuery) {
                history.append(nameQuery)
                saveHistory()
            }
        }
    }
    
    /// Remove query from history on UserDefaults
    func removeQuery(on index: Int) {
        withTransaction(.init(animation: .bouncy(duration: 0.25))) {
            history.remove(at: index)
            saveHistory()
        }
    }
    
    /// Fill query with clicked history 
    func fillWithHistory(on index: Int) {
        withTransaction(.init(animation: .bouncy(duration: 0.25))) {
            nameQuery = history[index]
        }
    }
    
    /// Show alert
    /// - Parameters:
    ///   - error: Threw error
    private func showAlert(_ error: Error) {
        showAlert = true
        guard let AFError = error.asAFError?.underlyingError else {
            alertInfo = .init(
                title: error.localizedDescription
            )
            return
        }
        
        alertInfo = .init(
            title: AFError.localizedDescription
        )
    }
}
