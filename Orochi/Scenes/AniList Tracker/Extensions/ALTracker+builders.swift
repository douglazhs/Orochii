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
        if isTracking {
            trackerInfo()
        } else {
            trackerSearch()
        }
    }
    
    /// Tracking manga view
    @ViewBuilder
    func trackerInfo() -> some View {
        List {
            // MANGA INFORMATION
            mangaSection()
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            // ANILIST ACTIONS
            pickers()
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(BlurBackground(with: .view_background))
    }
    
    /// Tracker search view
    @ViewBuilder
    func trackerSearch() -> some View {
        
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
                isPresented = false
            } label: { Text("Update").fontWeight(.semibold) }
            .buttonStyle(.borderless)
        }
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        statesSection()
        dateSection()
    }
}
