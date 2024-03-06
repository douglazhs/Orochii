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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ChapterViewModel
    
    var body: some View {
        NavigationStack {
            List {
                pageLayoutSection().listRowBackground(Color.clear)
                readingModeSection().listRowBackground(Color.clear)
                pageQualitySection().listRowBackground(Color.clear)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(BlurBackground(with: .view_background))
            .navigationTitle("Reader Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(String.Common.done)
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
