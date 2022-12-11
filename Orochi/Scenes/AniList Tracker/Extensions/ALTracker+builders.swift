//
//  ALTracker+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

extension ALTracker {
    /// All view content
    @ViewBuilder
    func content() -> some View {
        List {
            self.mangaSection()
                .listSectionSeparator(.hidden)
                .listRowBackground(Color.clear)
            self.currentContext()
        }
        .scrollContentBackground(.hidden)
        .listStyle(.grouped)
    }
    
    /// Update anilist button
    @ViewBuilder
    func updateTrackingButton() -> some View {
        Button {
            // TODO: - Save changes
            withAnimation(.easeInOut(duration: 0.175)) {
                action.wrappedValue = true
            }
            Haptics.shared.notify(.success)
            dismiss()
        } label: { Text("Update").fontWeight(.semibold) }
        .tint(.indigo)
        .buttonStyle(.borderless)
    }
    
    /// Current manga context
    @ViewBuilder
    func currentContext() -> some View {
        EnumPicker("", selection: $vm.currentContext)
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        switch vm.currentContext {
        case .states: self.statesSection()
                .listRowBackground(Color.clear)
        case .dates:  self.dateSection()
                .listRowBackground(Color.clear)
        case .score:  self.scoreSection()
                .listRowBackground(Color.clear)
        }
    }
}
