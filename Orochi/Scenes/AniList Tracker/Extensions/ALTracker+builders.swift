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
        VStack(alignment: .leading, spacing: 10) {
            self.actionsButtons()
            self.mangaSection()
            self.statesSection()
            self.scoreSection()
            self.dateSection()
        }
    }
    
    /// Update anilist button
    @ViewBuilder
    func actionsButtons() -> some View {
        HStack {
            Button {
                // TODO: - Cancel changes
                dismiss()
            } label: { Text("Cancel") }
            Spacer()
            Button {
                // TODO: - Save changes
                withAnimation(.easeInOut(duration: 0.175)) {
                    action.wrappedValue = true
                }
                Haptics.shared.notify(.success)
                dismiss()
            } label: { Text("Update").fontWeight(.semibold) }
        }
        .tint(.indigo)
        .buttonStyle(.borderless)
    }
}
