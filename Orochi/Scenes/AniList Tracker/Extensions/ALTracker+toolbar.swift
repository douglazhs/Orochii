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
        .tint(.white.opacity(0.75))
    }
    
    /// Close screen button
    @ViewBuilder
    func closeButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(.white.opacity(0.75))
        .clipShape(Circle())
        .buttonStyle(.bordered)
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
                .fontWeight(.black)
        }
        .buttonStyle(.borderless)
        .disabled(vm.alManga == nil)
    }
}
