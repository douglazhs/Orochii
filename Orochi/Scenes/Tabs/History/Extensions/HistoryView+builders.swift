//
//  HistoryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

extension HistoryView {
    /// All main content
    @ViewBuilder
    func content() -> some View {
        List {
            // TODO: Make a ForEach to show all dates sections
            self.dateSection("27/12/2022", readMangas: [
                MangaDomain.samples[1],
                MangaDomain.samples[11]
            ])
            self.dateSection("10/11/2019", readMangas: [
                MangaDomain.samples[2],
                MangaDomain.samples[4],
                MangaDomain.samples[12]
            ])
        }
        .listStyle(.grouped)
    }
    
    /// Clear history button
    @ViewBuilder
    func clearHistoryButton() -> some View {
        Button(role: .destructive) {
            //TODO: - Clear manga chapters read history
            showConfirmAction = true
        } label: { Image(systemName: "trash") }
        .confirmationDialog(
            "Clear History",
            isPresented: $showConfirmAction,
            titleVisibility: .visible
        ) {
            Button(role: .destructive) {
                withAnimation(.easeInOut(duration: 0.175)) {
                    vm.action = true
                }
                Haptics.shared.notify(.error)
                dismiss()
            } label: { Text("Clear") }
        } message: {
            Text("Are you sure you want to clear your chapters history?")
        }
    }
    
    /// Read date section
    @ViewBuilder
    func dateSection(
        _ date: String,
        readMangas: [MangaDomain]
    ) -> some View {
        Section {
            ForEach(readMangas) { manga in
                ZStack {
                    NavigationLink { MangaView(manga) } label: {
                        EmptyView()
                    }
                    .frame(width: 0)
                    .opacity(0)
                    HistoryMangaCell(of: manga)
                }
            }
        } header: {
            HStack {
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fontWeight(.regular)
                VStack { Divider() }
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}
