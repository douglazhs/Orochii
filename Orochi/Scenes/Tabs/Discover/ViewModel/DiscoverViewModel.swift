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
    /// Carousel sections
    @Published var sections: [Carousel] = [Carousel]()
    // MARK: - Searching stuffs
    @Published var nameQuery: String = ""
    @Published var searchResult: [Manga]?
    @Published var isSearching: Bool = false
    // MARK: - MangaDex request handling
    @Published var nsfw: Bool = false
    @Published var languages: [Language] = [Language]()
    @Published var shouldReload: Bool = false
    // MARK: - Error alert
    @Published var showAlert: Bool = false
    var alertInfo: AlertInfo = .init()
    
    init() {
        loadPreferences()
        generateSections()
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
    }
    
    /// Generate Main screen carousel dictionary
    /// - Returns: All main view carousel
    private func generateSections() {
        sections = CarouselSection.allCases.compactMap { Carousel($0) }
        Task { @MainActor in
            sections.indices.forEach { [weak self] index in
                if let section = self?.sections[index] {
                    self?.fetch(section.config) { [weak self] in
                        self?.sections[index].mangas = $0
                    }
                }
            }
        }
    }
    
    /// Fetch mangas
    /// - Parameters:
    ///   - carousel: Current carousel
    ///   - offset: Current request offset
    ///   - completion: Manga request result
    private func fetch(_ section: CarouselSection, offset: Int = 0, completion: @escaping([Manga]) -> Void) {
        api.getRandomManga(
            params: merge(section.params, into: defaults()),
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let array):
                completion(array.data)
            case .failure(let error):
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
                    self?.searchResult = array.data
                    withTransaction(.init(animation: .easeInOut(duration: 0.225))) {
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
    func hasReachedEnd(of manga: Manga, on index: Int) -> Bool {
        sections[index].mangas?.last?.id == manga.id
    }
    
    /// Fetch more mangas
    /// - Parameter index: carousel index
    func fetchMore(on index: Int) {
        guard sections[index].offset <= 150 else { return }
        sections[index].offset += 30
        
        fetch(
            sections[index].config,
            offset: sections[index].offset
        ) { [weak self] mangas in
            withTransaction(.init(animation: .easeInOut(duration: 0.25))) {
                self?.sections[index].mangas?.append(contentsOf: mangas)
            }
        }
    }
    
    /// Reload discover content
    func reload() {
        if shouldReload {
            Task { @MainActor in
                sections.indices.forEach { index in
                    fetch(sections[index].config) { [weak self] in
                        self?.sections[index].mangas = $0
                    }
                }
            }
        }
        withTransaction(.init(animation: .easeInOut(duration: 0.25))) {
            shouldReload = false
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
