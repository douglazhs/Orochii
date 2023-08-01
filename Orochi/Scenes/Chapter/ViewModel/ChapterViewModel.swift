//
//  ChapterViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import MangaDex

final class ChapterViewModel: ObservableObject, MangaHelpers {
    enum Format {
        case webtoon, normal
    }
    private (set) var manga: Manga
    private (set) var feed: [Chapter]
    @Published var api: MangaDexAPI = MangaDexAPI()
    @Published var actualPage: Double = 0
    @Published var format: Format = .normal
    @Published var readingMode: ReadingMode = .defaultMode
    @Published var pageLayout: PageLayout = .automatic
    @Published var pageQuality: MangaQuality = .original
    @Published var current: Chapter
    @Published var pages: ChapterResource?
    @Published var currentPage: UIImage?
    
    init(_ current: Chapter, _ feed: [Chapter], _ manga: Manga) {
        self.current = current
        self.feed = feed
        self.manga = manga
        fetchChapter()
        loadDefaults()
        defineReadingMode()
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
    
    /// Save current page on gallery
    func savePage(_ page: String) {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(page)
    }
    
    /// Define manga reading mode
    func defineReadingMode() {
        guard getTag("Web Comic", of: manga) != nil,
              getTag("Full Color", of: manga) != nil
        else {
            format = .normal
            return
        }
        format = .webtoon
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
    
    /// Chapter pages count
    func pagesCount() -> Int {
        switch pageQuality {
        case .original: return pages?.data?.count ?? 0
        case .dataSaver: return pages?.dataSaver?.count ?? 0
        }
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
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.ReaderPreferences.pageQuality.rawValue)
        ) ?? .original
    }
}
