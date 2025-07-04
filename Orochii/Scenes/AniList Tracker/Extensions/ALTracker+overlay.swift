//
//  ALTracker+overlay.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI

extension ALTracker {
    /// Track locally overlay
    @ViewBuilder
    func trackLocallyOverlay() -> some View {
        if !vm.trackingLocally {
            ZStack {
                Color.black.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20.0) {
                    if !vm.isLoading {
                        trackingInfo()
                        Divider()
                        trackAction()
                    } else { ActivityIndicator() }
                }.padding()
            }
        }
    }
    
    /// Tracking mang information
    @ViewBuilder
    func trackingInfo() -> some View {
        Group {
            VStack(spacing: 20.0) {
                HStack(spacing: 30.0) {
                    VStack(alignment: .leading, spacing: 5.0) {
                        Text(L.Tracker.Info.status)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
                        Text(vm.alManga?.mediaListEntry?.status ?? "-")
                    }
                    VStack(alignment: .center, spacing: 5.0) {
                        Text(L.Tracker.Info.progress)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
                        Text(
                            L.Tracker.Info.chapter(
                                (vm.alManga?.mediaListEntry?.progress.nilToStr ?? "-") + "/" +
                                (vm.alManga?.chapters.nilToStr ?? "-")
                            )
                        )
                    }
                    VStack(alignment: .trailing, spacing: 5.0) {
                        Text(L.Tracker.Info.updated)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(Asset.Colors.secondaryText.swiftUIColor)
                        
                        Text(Date.getDate(
                            of: vm.alManga?.mediaListEntry?.updatedAt ?? 0,
                            format: "dd MMM yy"
                        ))
                    }
                }
            }
        }
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .fontWeight(.semibold)
        .foregroundColor(.primary.opacity(0.85))
    }
    
    /// Start tracking or track locally action
    @ViewBuilder
    func trackAction() -> some View {
        Button {
            withAnimation(.spring()) {
                vm.trackingLocally = true
            }
        } label: {
            Label(
                vm.alManga?.mediaListEntry != nil
                ? L.Tracker.Action.trackLocally
                : L.Tracker.Action.startTracking,
                systemImage: vm.alManga?.mediaListEntry != nil
                ? "icloud.and.arrow.down"
                : "play"
            )
            .font(.subheadline)
            .fontWeight(.heavy)
            .foregroundStyle(
                vm.alManga?.mediaListEntry != nil
                ? .accentColor
                : Asset.Colors.button.swiftUIColor
            )
        }
        .buttonStyle(.borderless)
    }
}
