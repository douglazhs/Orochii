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
        ZStack(alignment: .bottom) {
            VStack(spacing: 22) {
                // UPDATE BUTTON
                self.updateTrackingButton()
                // MANGA INFORMATION
                self.mangaSection()
                // ANILIST ACTIONS
                self.pickers()
            }
            .padding(.top)
            .padding(.horizontal)
            .background(BlurBackground(with: manga.cover))
        }
    }
    
    /// Update anilist button
    @ViewBuilder
    func updateTrackingButton() -> some View {
        HStack {
            Spacer()
            Button {
                // TODO: - Save changes
                withAnimation(.easeInOut(duration: 0.175)) {
                    action.wrappedValue = true
                }
                Haptics.shared.notify(.success)
            } label: { Text("Update").fontWeight(.semibold) }
                .tint(.indigo)
                .buttonStyle(.borderless)
        }
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        self.statesSection()
        self.dateSection()
    }
}
