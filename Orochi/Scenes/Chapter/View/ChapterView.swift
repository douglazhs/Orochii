//
//  ChapterView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import MangaDex

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ChapterViewModel
    @State var showReadBars: Visibility = .visible
    @State var showChaptersList: Bool = false
    @State var showReaderPreferences: Bool = false
    
    init(_ current: Chapter, _ feed: [Chapter], of manga: Manga) {
        self._vm = StateObject(
            wrappedValue: ChapterViewModel(current, feed, manga)
        )
    }
    
    var body: some View {
        NavigationStack {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.editor)
                .toolbar(showReadBars, for: .navigationBar, .bottomBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .statusBarHidden(showReadBars == .hidden)
                .fontDesign(.rounded)
                .readerToolbar(
                    showChaptersList: $showChaptersList,
                    showReaderPreferences: $showReaderPreferences
                )
                .environmentObject(vm)
                .animation(.default, value: [showReadBars])
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
