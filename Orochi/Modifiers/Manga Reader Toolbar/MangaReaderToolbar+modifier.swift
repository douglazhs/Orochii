//
//  MangaReaderToolbar+modifier.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import struct MangaDex.Manga

extension View {
    func readerToolbar(
        showChaptersList: Binding<Bool>,
        showReaderPreferences: Binding<Bool>
    ) -> some View {
        modifier(ReaderToolbar(
            showChaptersList: showChaptersList,
            showReaderPreferences: showReaderPreferences)
        )
    }
}
