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
            if vm.trackingLocally {
                Button {
                    showConfirmation = true
                } label: {
                    Label("Stop tracking", systemImage: "stop.fill")
                }
            }
            
            Button { [weak vm] in
                if let alId =  vm?.mDexManga.attributes?.links?.al,
                   let url = URL(string: "\(AppURLs.ALSite)/manga/\(alId)") {
                    vm?.alUrl = url
                    showWebView = true
                }
            } label: {
                Label("See on AniList", systemImage: "safari")
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
        } label: { Text("Track").fontWeight(.semibold) }
        .buttonStyle(.borderless)
        .disabled(vm.alManga == nil)
    }
}
