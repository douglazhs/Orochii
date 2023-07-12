//
//  MangaHistoryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

extension MangaHistoryView {
    /// All main content
    @ViewBuilder
    func content() -> some View {
        List {
            // TODO: - Make a ForEach to see all read dates
            dateSection("10/12/2021", readChapters: [
                ChapterDomain.samples[0],
                ChapterDomain.samples[5]
            ])
            .listRowBackground(Color.clear)
            dateSection("11/03/2022", readChapters: [
                ChapterDomain.samples[2],
                ChapterDomain.samples[8],
                ChapterDomain.samples[3]
            ])
            .listRowBackground(Color.clear)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(BlurBackground(with: .view_background))
    }
    
    /// Date with all read chapters
    @ViewBuilder func dateSection(
        _ date: String,
        readChapters: [ChapterDomain]
    ) -> some View {
        Section {
            ForEach(readChapters) { chapter in
                HistoryChapterCell(of: chapter)
            }
        } header: {
            Text(manga.lastUpdated)
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    /// Clear manga history button
    @ViewBuilder
    func clearHistoryButton() -> some View {
        Button("Clear", role: .destructive) {
            // TODO: - Clear a specific manga history
            showConfirmAction = true
        }
        .tint(.red)
        .alert("Clear History", isPresented: $showConfirmAction) {
            Button("Clear", role: .destructive) {
                // TODO: Clear history
                withAnimation(.easeInOut(duration: 0.175)) {
                    action.wrappedValue = true
                }
                Haptics.shared.notify(.error)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to clear your \"\(manga.title)\" chapters history?")
        }
    }
}
