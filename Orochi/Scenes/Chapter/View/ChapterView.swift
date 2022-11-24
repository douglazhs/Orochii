//
//  ChapterView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

struct ChapterView: View {
    @StateObject var vm: ChapterViewModel
    @State var showReadBars: Visibility = .visible
    @State var showChaptersList: Bool = false
    @State var showReaderPreferences: Bool = false
    var manga: MangaDomain
    var chapter: ChapterDomain
    
    init(_ chapter: ChapterDomain, of manga: MangaDomain) {
        self.chapter = chapter
        self.manga = manga
        self._vm = StateObject(
            wrappedValue: ChapterViewModel(actualChapter: chapter)
        )
    }
    
    var body: some View {
        NavigationStack {
            self.content()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.editor)
                .toolbar(showReadBars, for: .bottomBar, .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .statusBarHidden(showReadBars == .hidden)
                .readerToolbar(
                    manga: manga,
                    showChaptersList: $showChaptersList,
                    showReaderPreferences: $showReaderPreferences
                )
                .environmentObject(vm)
                .animation(.spring(), value: [showReadBars])
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(ChapterDomain.samples[0], of: MangaDomain.samples[0])
    }
}
