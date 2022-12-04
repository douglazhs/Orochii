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
            Section {
                HistoryChapterCell(
                    of: ChapterDomain.samples[1]
                )
            } header: {
                Text(manga.lastUpdated)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(
            BlurBackground(with: manga.cover)
                .opacity(0.75)
        )
    }
    
    /// Clear manga history button
    @ViewBuilder
    func clearHistoryButton() -> some View {
        Button(role: .destructive) {
            // TODO: - Clear a specific manga history
            showConfirmAction = true
        } label: { Image(systemName: "trash") }
        .tint(.red)
        .alert("Clear History", isPresented: $showConfirmAction) {
            Button(role: .destructive) {
                // TODO: Clear history
                withAnimation(.easeInOut(duration: 0.175)) {
                    action.wrappedValue = true
                }
                Haptics.shared.notify(.error)
                dismiss()
            } label: {
                Text("Clear")
            }
        } message: {
            Text("Are you sure you want to clear your \"\(manga.title)\" chapters history?")
        }
    }
}
