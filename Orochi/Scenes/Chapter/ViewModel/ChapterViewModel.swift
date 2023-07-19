//
//  ChapterViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import MangaDex

class ChapterViewModel: ObservableObject {
    private (set) var manga: Manga
    private (set) var feed: [Chapter]
    @Published var api: MangaDexAPI = MangaDexAPI()
    @Published var actualPage: Int = 0
    @Published var readingMode: ReadingMode = .defaultMode
    @Published var pageLayout: PageLayout = .automatic
    @Published var pageQuality: MangaQuality = .original
    @Published var current: Chapter
    @Published var pages: ChapterResource?
    
    init(_ current: Chapter, _ feed: [Chapter], _ manga: Manga) {
        self.current = current
        self.feed = feed
        self.manga = manga
        fetchChapter()
        loadDefaults()
    }
    
    /// Fetch current chapter
    func fetchChapter() {
        guard let id = current.id else { return }
        api.getChapter(id: id) { result in
            switch result {
            case .success(let data):
                self.pages = data.chapter
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    /// Choose array based on user quality preference
    /// - Returns: Array of images
    func choosenQuality() -> [String] {
        if let data = pages?.data, let dataSaver = pages?.dataSaver {
            switch pageQuality {
            case .original: return data
            case .dataSaver: return dataSaver
            }
        }
        return[]
    }
    
    /// Load user defaults
    func loadDefaults() {
        pageLayout = PageLayout(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.pageLayout.rawValue)
        ) ?? .automatic
        readingMode = ReadingMode(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.mode.rawValue)
        ) ?? .defaultMode
        pageQuality = MangaQuality(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.SrcPreferences.quality.rawValue)
        ) ?? .original
    }
}
