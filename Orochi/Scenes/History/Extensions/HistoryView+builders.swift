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
            self.dateSection()
        }
        .listStyle(.plain)
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
            isPresented: $showConfirmAction
        ) {
            Button(role: .destructive) {
                // TODO: Clear history
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
    func dateSection() -> some View {
        Section {
            HistoryMangaCell(
                of: MangaDomain.samples[0],
                truncated: $vm.truncated
            )
            if vm.truncated {
                HorizontalTineline()
            }
        } header: {
            Text("27/12/2022")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}
