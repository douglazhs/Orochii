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
                        Text("STATUS")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        Text(vm.alManga?.mediaListEntry?.status ?? "-")
                    }
                    VStack(alignment: .center, spacing: 5.0) {
                        Text("PROGRESS")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        Text("CH. \(vm.alManga?.mediaListEntry?.progress.nilToStr ?? "-")" +
                             "/\(vm.alManga?.chapters.nilToStr ?? "-")")
                    }
                    VStack(alignment: .trailing, spacing: 5.0) {
                        Text("UPDATED")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        if vm.alManga?.mediaListEntry != nil {
                            Text(Date.getDate(
                                of: vm.alManga?.mediaListEntry?.updatedAt ?? 0,
                                format: "dd MMM yy"
                            ))
                        } else { Text("-") }
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
                ? "Track locally"
                : "Start tracking",
                systemImage: vm.alManga?.mediaListEntry != nil
                ? "icloud.and.arrow.down"
                : "play.fill"
            )
            .font(.subheadline)
            .fontWeight(.black)
        }
        .buttonStyle(.borderless)
    }
}
