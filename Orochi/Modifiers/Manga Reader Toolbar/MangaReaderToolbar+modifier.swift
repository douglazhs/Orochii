//
//  MangaReaderToolbar+modifier.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension View {
    func readerToolbar(
        manga: MangaDomain,
        showChaptersList: Binding<Bool>,
        showReaderPreferences: Binding<Bool>
    ) -> some View {
        modifier(ReaderToolbar(
            manga: manga,
            showChaptersList: showChaptersList,
            showReaderPreferences: showReaderPreferences)
        )
    }
}
