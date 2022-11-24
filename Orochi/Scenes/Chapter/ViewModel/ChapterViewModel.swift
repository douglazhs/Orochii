//
//  ChapterViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

class ChapterViewModel: ObservableObject {
    @Published var actualPage: Double = 0
    @Published var readingMode: ReadingMode = .defaultMode
    @Published var pageLayout: PageLayout = .automatic
    @Published var actualChapter: ChapterDomain
    
    init(actualChapter: ChapterDomain) {
        self.actualChapter = actualChapter
    }
    
    /// Put manga on this initial state
    func loadChapter() {
        self.actualPage = 0
    }
}
