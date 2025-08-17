//
//  ReaderPreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import class MangaDex.MangaMock
import class MangaDex.ChapterMock

struct ReaderPreferencesView: View {
    @Environment(\.dismiss) 
    var dismiss
    @EnvironmentObject var vm: ChapterViewModel
    
    var body: some View {
        NavigationStack {
            List {
                pageLayoutSection()
                readingModeSection()
                pageQualitySection()
            }
            .standardBars(title: L.Reader.title, inline: true)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(L.Common.done)
                    }
                }
            }
        }
    }
}

#Preview {
    ReaderPreferencesView()
        .environmentObject(ChapterViewModel(
            ChapterMock.chapter,
            [ChapterMock.chapter],
            MangaMock.manga)
        )
}
