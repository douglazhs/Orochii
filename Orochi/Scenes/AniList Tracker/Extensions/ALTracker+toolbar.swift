//
//  ALTracker+toolbar.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI

extension ALTracker {
    /// Update anilist button
    @ViewBuilder
    func anilistMangaOptions() -> some View {
        Menu {
            Section {
                if vm.trackingLocally {
                    Button {
                        showConfirmation = true
                    } label: {
                        Label("Stop tracking", systemImage: "stop.fill")
                    }
                }
                
                Button { [weak vm] in
                    if let siteUrl = vm?.alManga?.siteUrl,
                        let url = URL(string: siteUrl) {
                        vm?.alUrl = url
                        showWebView = true
                    }
                } label: {
                    Label("See on AniList", systemImage: "safari")
                }
            } header: {
                Text(vm.alManga?.title?.romaji ?? vm.alManga?.title?.english ?? "")
            }
        } label: {
            Image(systemName: "ellipsis")
        }
        .confirmationDialog(
            "Stop tracking locally",
            isPresented: $showConfirmation,
            titleVisibility: .visible
        ) {
            Button("Stop", role: .destructive) { dismiss() }
        } message: {
            Text("You will not lose your AniList progress, just remove the track information locally.")
        }
    }
    
    /// Track manga button
    @ViewBuilder
    func trackButton() -> some View {
        Button { [weak vm] in
            vm?.trackingLocally = true
            vm?.handleTracking()
        } label: {
            Text("TRACK")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundStyle(vm.alManga == nil ? Color.ORCH.secondaryText : Color.ORCH.button)
        }
        .buttonStyle(.borderless)
        .disabled(vm.alManga == nil)
    }
    
    /// Save progress button
    @ViewBuilder
    func saveButton() -> some View {
        Button("SAVE") { dismiss() }
            .font(.subheadline)
            .fontWeight(.heavy)
            .foregroundStyle(Color.ORCH.button)
    }
}
