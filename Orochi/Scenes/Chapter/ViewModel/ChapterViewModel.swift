//
//  ChapterViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import MangaDex

extension ChapterViewModel: MangaHelpers { }

final class ChapterViewModel: ObservableObject {
 
    /// Actual reading **Manga**
    private (set) var manga: Manga
    /// Current **Manga** feed
    private (set) var feed: [Chapter]
    /// MangaDex Api object
    let api: MangaDexAPI = MangaDexAPI()
    // MARK: - Chapter configuration
    @Published var format: Format = .normal
    @Published var readingMode: ReadingMode = .defaultMode
    @Published var pageLayout: PageLayout = .automatic
    @Published var pageQuality: MangaQuality = .original
    // MARK: - Chapter handler
    /// Current selected  **Manga**
    @Published var current: Chapter
    @Published var content: ChapterResource?
    @Published var pages: [String] = []
    @Published var actualPage: Double = 0
    // MARK: - Possible errors
    @Published var error: Error?
    
    /// Chaper View Model
    /// - Parameters:
    ///   - current: reading chapter
    ///   - feed: current manga chapter collection
    ///   - manga: reading manga
    init(_ current: Chapter, _ feed: [Chapter], _ manga: Manga) {
        self.current = current
        self.feed = feed
        self.manga = manga
        initalBuild()
    }
    
    /// Make initial **chapter** build
    private func initalBuild() {
        loadDefaults()
        defineReadingMode()
        fetchChapter()
    }
    
    /// Fetch current ``MangaDex/Chapter``
    func fetchChapter() {
        guard let id = current.id else { return }
        api.getChapter(id: id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.content = data.chapter
                self?.buildPages()
            case .failure(let error):
                self?.error = error.asAFError?.underlyingError
            }
        }
    }
    
    /// Save current reading page on gallery
    func savePage(of index: Int) {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(pages[index])
    }
    
    /// Define manga reading mode based on ``Format``
    private func defineReadingMode() {
        guard getTag("Web Comic", of: manga) != nil,
            getTag("Full Color", of: manga) != nil
        else {
            format = .normal
            return
        }
        format = .webtoon
    }
    
    /// Choose array based on user ``MangaQuality`` preference
    private func buildPages() {
        switch pageQuality {
        case .original:
            guard let data = content?.data else {
                pages = []
                return
            }
            pages = data
            return
        case .dataSaver:
            guard let dataSaver = content?.dataSaver else {
                pages = []
                return
            }
            pages = dataSaver
        }
    }
    
    /// Load user defaults
    private func loadDefaults() {
        pageLayout = PageLayout(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.pageLayout.rawValue)
        ) ?? .automatic
        readingMode = ReadingMode(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.mode.rawValue)
        ) ?? .defaultMode
        pageQuality = MangaQuality(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.pageQuality.rawValue)
        ) ?? .original
    }
}
