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
                        Label(L.Tracker.Action.stopTracking, systemImage: "stop.fill")
                    }
                }
                
                Button { [weak vm] in
                    if let siteUrl = vm?.alManga?.siteUrl,
                        let url = URL(string: siteUrl) {
                        vm?.alUrl = url
                        showWebView = true
                    }
                } label: {
                    Label(L.Tracker.Action.seeOnAnilist, systemImage: "safari")
                }
            } header: {
                Text(vm.alManga?.title?.romaji ?? vm.alManga?.title?.english ?? "")
            }
        } label: {
            Image(systemName: "ellipsis")
        }
        .confirmationDialog(
            L.Tracker.Stop.Confirmation.title,
            isPresented: $showConfirmation,
            titleVisibility: .visible
        ) {
            Button(L.Tracker.Action.stop, role: .destructive) { dismiss() }
        } message: {
            Text(L.Tracker.Stop.Confirmation.message)
        }
    }
    
    /// Track manga button
    @ViewBuilder
    func trackButton() -> some View {
        Button { [weak vm] in
            vm?.trackingLocally = true
            vm?.handleTracking()
        } label: {
            Text(L.Tracker.Action.track)
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundStyle(vm.alManga == nil ? Asset.Colors.secondaryText.swiftUIColor : Asset.Colors.button.swiftUIColor)
        }
        .buttonStyle(.borderless)
        .disabled(vm.alManga == nil)
    }
    
    /// Save progress button
    @ViewBuilder
    func saveButton() -> some View {
        Button(L.Common.save.uppercased()) { dismiss() }
            .font(.subheadline)
            .fontWeight(.heavy)
            .foregroundStyle(Asset.Colors.button.swiftUIColor)
    }
}
